package com.datastax.loader;

import com.datastax.driver.core.*;
import com.datastax.driver.core.policies.*;
import java.util.*;
import java.io.*;

public class DelimLoad {
    private static Map<String, DelimParser.Parsing> pmap;

    private static void initPmap() {
	pmap = new HashMap<String, DelimParser.Parsing>();
	pmap.put("INT", DelimParser.intParser);
	pmap.put("INTEGER", DelimParser.intParser);
	pmap.put("DOUBLE", DelimParser.doubleParser);
	pmap.put("BIGINT", DelimParser.longParser);
	pmap.put("TEXT", DelimParser.stringParser);
    }

    public static List<SchemaBits> parseSchema(String in) {
	String[] tary1 = in.split("\\Q,\\E");
	List<SchemaBits> sbl = new ArrayList<SchemaBits>(tary1.length);
	for (int i = 0; i < tary1.length; i++) {
	    String [] tary2 = tary1[i].trim().split("\\s+");
	    if (2 != tary2.length) {
		System.err.println("Bad schema substring ('" + tary1[i].trim() + "')");
		System.exit(-1);
	    }
	    SchemaBits sb = new SchemaBits();
	    sb.name = tary2[0];
	    DelimParser.Parsing p = pmap.get(tary2[1].toUpperCase());
	    if (null == p) {
		System.err.println("Bad data type in schema ('" + tary1[i].trim() + "')");
		System.exit(-1);
	    }
	    sb.parser = p;
	    sbl.add(sb);
	}
	return sbl;
    }

    public static String generateInsert(String ks, String tn, List<SchemaBits> sb) {
	String insert = "INSERT INTO " + ks + "." + tn + "(" + sb.get(0).name;
	String qmarks = "?";
	for (int i = 1; i < sb.size(); i++) {
	    insert = insert + ", " + sb.get(i).name;
	    qmarks = qmarks + ", ?";
	}
	insert = insert + ") VALUES (" + qmarks + ")";
	return insert;
    }

    public static void main(String[] args) throws IOException {
	if (args.length != 3) {
	    System.err.println("Expecting 2 arguments: <filename> <ipaddress> <schema>");
	    System.exit(1);
	}
	String filename = args[0];
	String host = args[1];
	String inSchema = args[2];
	int MAX_ERRORS = 10;
	String delimiter = "\\Q|\\E";

	initPmap();
	String[] tary1 = inSchema.trim().split("\\Q(\\E");
	if (2 != tary1.length) {
	    System.err.println("Badly formatted schema\n");
	    System.exit(-1);
	}
	String[] tary2 = tary1[0].split("\\Q.\\E");
	if (2 != tary1.length) {
	    System.err.println("Badly formatted schema - specify keyspace and tablename\n");
	    System.exit(-1);
	}
	String keyspace = tary2[0].trim();
	String table = tary2[1].trim();
	
	tary2 = tary1[1].split("\\Q)\\E");
	List<SchemaBits> sbl = parseSchema(tary2[0]);

	String insert = generateInsert(keyspace, table, sbl);

	BufferedReader reader = new BufferedReader(new FileReader(filename));

	Cluster cluster = Cluster.builder()
	    .addContactPoint(host)
	    .withPort(9042)
	    .withLoadBalancingPolicy(new TokenAwarePolicy( new DCAwareRoundRobinPolicy()))
	    .build();
	Session session = cluster.newSession();

	PreparedStatement statement = session.prepare(insert);
	List<ResultSetFuture> futures = new ArrayList<ResultSetFuture>();

	DelimParser parser = new DelimParser(delimiter);
	for (int i = 0; i < sbl.size(); i++)
	    parser.add(sbl.get(i).parser);
   
	String line;
	int lineNumber = 1;
	int numErrors = 0;
	while ((line = reader.readLine()) != null) {
	    if (999 == lineNumber % 1000) {
		for (ResultSetFuture future: futures) {
		    future.getUninterruptibly();
		}
		futures.clear();
	    }
	    if (parser.parse(line)) {
		BoundStatement bind = statement.bind(parser.getElements());
		ResultSetFuture resultSetFuture = session.executeAsync(bind);
		futures.add(resultSetFuture);
	    }
	    else {
		System.err.println(String.format("Error parsing line %d in %s: %s", lineNumber, filename, line));
		numErrors++;
		if (MAX_ERRORS <= numErrors) {
		    System.err.println(String.format("Maximum number of errors exceeded (%d)", numErrors));
		    cluster.close();
		    System.exit(-1);
		}
	    }
	    lineNumber++;
	}

	for (ResultSetFuture future: futures) {
	    future.getUninterruptibly();
	}
	futures.clear();

	System.err.println("*** DONE: " + filename + "   number of lines loaded: " + (lineNumber-1));

	cluster.close();
    }

    public static class SchemaBits {
	public String name;
	public DelimParser.Parsing parser;
    }
}

