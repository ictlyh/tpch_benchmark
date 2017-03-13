#!/bin/sh

if [ $# -ne 3 ]; then
    echo "Usage: $0 host port dbname"
    exit 1
fi

HOST=$1
PORT=$2
DBNAME=$3

# log
LOGFILE=bench.log

ROOT=$(dirname $(readlink -f $0))
TPCH_HOME=${ROOT}/../tpch
RESULTS=${ROOT}/results

function benchmark_run() {
  # store the settings
  psql -h $HOST -p $PORT -d $DBNAME -c "select name,setting from pg_settings" > $RESULTS/settings.log 2> $RESULTS/settings.err

  print_log "preparing TPC-H database"

  print_log "  creating tables"
  psql -h $HOST -p $PORT -d $DBNAME -f ${ROOT}/create_table.sql > $RESULTS/create_table.log 2> $RESULTS/create_table.err

  print_log "  loading data"

  psql -h $HOST -p $PORT  -d $DBNAME -f ${ROOT}/load_data.sql > $RESULTS/load_data.log 2> $RESULTS/load_data.err

  print_log "  creating indexes"

  psql -h $HOST -p $PORT  -d $DBNAME -f ${ROOT}/create_index.sql > $RESULTS/create_index.log 2> $RESULTS/create_index.err

  print_log "running TPC-H benchmark"

  benchmark_dss

  print_log "finished TPC-H benchmark"
}

function benchmark_dss() {
  mkdir $RESULTS/explain $RESULTS/results $RESULTS/errors

  # get bgwriter stats
  psql  -p $PORT  -d $DBNAME -c "SELECT * FROM pg_stat_bgwriter" > $RESULTS/stats-before.log 2>> $RESULTS/stats-before.err
  psql  -p $PORT  -d $DBNAME -c "SELECT * FROM pg_stat_database WHERE datname = '$DBNAME'" >> $RESULTS/stats-before.log 2>> $RESULTS/stats-before.err

  print_log "running queries defined in TPC-H benchmark"

  for n in `seq 1 22`
  do
    q="${ROOT}/queries/$n.sql"
    qe="${ROOT}/queries/$n.explain.sql"

    if [ -f "$q" ]; then
      print_log "  running query $n"
      # run explain
      psql -h $HOST -p $PORT  -d $DBNAME -f $qe > $RESULTS/explain/$n 2>> $RESULTS/explain.err
      psql -h $HOST -p $PORT  -d $DBNAME -f $q > $RESULTS/results/$n 2> $RESULTS/errors/$n
    fi;
  done;

  # collect stats again
  psql -h $HOST -p $PORT -d $DBNAME -c "SELECT * FROM pg_stat_bgwriter" > $RESULTS/stats-after.log 2>> $RESULTS/stats-after.err
  psql -h $HOST -p $PORT -d $DBNAME -c "SELECT * FROM pg_stat_database WHERE datname = '$DBNAME'" >> $RESULTS/stats-after.log 2>> $RESULTS/stats-after.err
}

function print_log() {
  local message=$1
  echo `date +"%Y-%m-%d %H:%M:%S"` "["`date +%s`"] : $message" >> $RESULTS/$LOGFILE;
}

rm -rf $RESULTS
mkdir -p $RESULTS

# run the benchmark
benchmark_run
