# TPC-H Benchmark on Cloudera Impala, PostgreSQL and Citus

## This README covers the following topics.
1. How to generate/prepare the data
2. How to run the queries on Impala, PostgreSQL and Citus

## This README un-covers how to install Impala, PostgreSQL or Citus.

## How to generate/prepare the data
The data is generated using the DBGEN software on TPC-H website.  
See README in the DBGEN install package on details of how to generate the dataset. 

There's a script for generating data in directory `./data`
> $sh generate\_data.sh scale\_factor

## How to run the queries

### Run queries on Impala
> $ sh impala/main.sh HOST PORT DBNAME IMPALA\_HOME HADOOP\_HOME  

After finishing all queries, you can read logs in directory `./impala/results`

### Run queries on PostgreSQL
> $ sh postgresql/main.sh HOST PORT DBNAME  

After finishing all queries, you can read logs in directory `./postgresql/results`

### Run queries on Citus
> $ sh citus/main.sh HOST PORT DBNAME  

After finishing all queries, you can read logs in directory `./citus/results`

## Reference
[The original TPC-H on Hive](https://issues.apache.org/jira/browse/HIVE-600 "https://issues.apache.org/jira/browse/HIVE-600")  
[kj-ki/tpc-h-impala](https://github.com/kj-ki/tpc-h-impala "https://github.com/kj-ki/tpc-h-impala")  
[trondra/pg_tpch](https://github.com/tvondra/pg_tpch "https://github.com/tvondra/pg_tpch")
