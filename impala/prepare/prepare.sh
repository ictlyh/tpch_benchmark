#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 HADOOP_HOME DATADIR"
    exit 1
fi

HADOOP_HOME=$1
DATADIR=$2

${HADOOP_HOME}/bin/hdfs dfs -rmdir /tpch/ 
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/ 

${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/customer
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/lineitem
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/nation
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/orders
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/part
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/partsupp
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/region
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tpch/supplier

${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/customer.csv /tpch/customer/
${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/lineitem.csv /tpch/lineitem/
${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/nation.csv /tpch/nation/
${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/orders.csv /tpch/orders/
${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/part.csv /tpch/part/
${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/partsupp.csv /tpch/partsupp/
${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/region.csv /tpch/region/
${HADOOP_HOME}/bin/hdfs dfs -copyFromLocal ${DATADIR}/supplier.csv /tpch/supplier/
