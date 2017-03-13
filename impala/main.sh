#!/bin/sh

if [ $# -ne 5 ]; then
    echo "Usage: $0 host port dbname impala_home hadoop_home"
    exit 1
fi

HOST=$1
PORT=$2
DBNAME=$3
IMPALA_HOME=$4
HADOOP_HOME=$5

# log
LOGFILE=bench.log

ROOT=$(dirname $(readlink -f $0))
TPCH_HOME=${ROOT}/../tpch
RESULTS=${ROOT}/results

function benchmark_run() {
  print_log "uploading data to hdfs"
  sh ${ROOT}/prepare/prepare.sh ${HADOOP_HOME} ${ROOT}/data 

  print_log "running TPC-H benchmark"

  mkdir -p ${RESULTS}/prepare ${RESULTS}/queries
  source ${IMPALA_HOME}/bin/impala-config.sh

  for i in `seq 1 22`
  do
    if [ -f ${ROOT}/prepare/$i.sql ];then
      print_log "  preparing query $i"
      ${IMPALA_HOME}/bin/impala-shell.sh -i $HOST:$PORT -d $DBNAME -f ${ROOT}/prepare/$i.sql >${RESULTS}/prepare/$i.log 2>&1
    fi

    if [ -f ${ROOT}/queries/$i.sql ];then
      print_log "  running query $i"
      ${IMPALA_HOME}/bin/impala-shell.sh -i $HOST:$PORT -d $DBNAME -f ${ROOT}/queries/$i.sql >${RESULTS}/queries/$i.log 2>&1
    fi
  done

  print_log "finished TPC-H benchmark"
}

function print_log() {
  local message=$1
  echo `date +"%Y-%m-%d %H:%M:%S"` "["`date +%s`"] : $message" >> $RESULTS/$LOGFILE;
}

rm -rf $RESULTS
mkdir -p $RESULTS

# run the benchmark
benchmark_run
