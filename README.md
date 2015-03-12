#Cassandra TPC-DS

## Setup

To use this, you need to also clone the tpcds-kit GitHub repo, as we'll use that 
to generate the data.  It is expected that this repo and the tpcds-kit repo
are both cloned from the same directory, resulting in a tpcds-kit/ and cassandra-tpcds/ 
directory in the same directory.  If you do not do that, you will need to update
the Makefile appropriately.

STEPS:
1. clone this repo:
```
git clone 
```
2. clone the tpcds-kit repo:
```
git clone https://github.com/grahn/tpcds-kit.git
```
3. Build the tpcds-kit binaries
```
cd tpcds-kit/tools
make -f Makefile.suite
```
4. Make the data.  You will need to update the Makefile
with the desired TPCDS_SCALE_FACTOR.  It ships with the value
1, which is only for development purposes.
```
cd ../../cassandra-tpcds
make data
```
5. Create the keyspace and tables in Cassandra
```
make ddl
```
6. Load the data into Cassandra
```
make load
```

##Queries
The queries are Shark queries taken from the impala-tpcds-kit GitHub repo:
https://github.com/cloudera/impala-tpcds-kit/tree/master/queries-sql92-modified/queries/shark

They are queries 3, 7, 19, 27, 34, 42, 43, 46, 52, 53, 55, 59, 63, 65, 68, 73, 79, 89, 98, and ss_max.

A version which has been slightly modified to reference database names, not just bare table names, is in queries_full.

To use these queries, run
```
dse spark
use tpcds;
source queries/q19.sql;
```

You can then do whichever query you want from within the Shark shell.

