package com.datastax.loader;

import java.util.*;
import java.io.*;

public class DelimParser {
    private List<Parsing> parsers;
    private List<Object> elements;
    private String delimiter;
    private int parsersSize;

    public static DelimParser.Parsing intParser = new IntParser();
    public static DelimParser.Parsing longParser = new LongParser();
    public static DelimParser.Parsing doubleParser = new DoubleParser();
    public static DelimParser.Parsing stringParser = new StringParser();

    public DelimParser(String inDelimiter) {
	parsers = new ArrayList<Parsing>();
	elements = new ArrayList<Object>();
	parsersSize = parsers.size();
	delimiter = inDelimiter;
    }
    
    public void add(Parsing p) {
	parsers.add(p);
	parsersSize = parsers.size();
    }
    
    public void add(Collection<Parsing> pl) {
	parsers.addAll(pl);
	parsersSize = parsers.size();
    }
    
    boolean parse(String line) {
	String[] columns = line.split(delimiter, -1);
	if (parsersSize != columns.length) {
	    System.err.println(String.format("Invalid input: Expected %d elements, found %d", parsersSize, columns.length));
	    return false;
	}
	elements.clear();
	for (int i = 0; i < parsersSize; i++) {
	    try {
		elements.add(parsers.get(i).parse(columns[i]));
	    }
	    catch (NumberFormatException e) {
		System.err.println(String.format("Invalid number in input number %d ('%s')", i, columns[i]));
		return false;
	    }
	}
	return true;
    }

    public Object[] getElements() {
	return elements.toArray();
    }

    public static interface Parsing {
	public Object parse(String toparse);
    }

    public static class IntParser implements Parsing {
	public Object parse(String toparse) throws NumberFormatException {
	    if (0 == toparse.trim().length())
		return null;
	    return Integer.parseInt(toparse.trim());
	}
    }

    public static class LongParser implements Parsing {
	public Object parse(String toparse) throws NumberFormatException {
	    if (0 == toparse.trim().length())
		return null;
	    return Long.parseLong(toparse.trim());
	}
    }

    public static class DoubleParser implements Parsing {
	public Object parse(String toparse) throws NumberFormatException {
	    if (0 == toparse.trim().length())
		return null;
	    return Double.parseDouble(toparse.trim());
	}
    }

    public static class StringParser implements Parsing {
	public Object parse(String toparse) {
	    return toparse.trim();
	}
    }

}
