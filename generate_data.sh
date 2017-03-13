#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 scale"
    exit 1
fi

ROOT=$(dirname $(readlink -f $0))
TPCH_HOME=${ROOT}/tpch

pushd ${TPCH_HOME}/dbgen

make -f makefile.suite all

rm -rf *.tbl *.csv ${ROOT}/data

# generate data
./dbgen -s $1
for i in `ls *.tbl`
do
  # remove last delimiter '|'
  sed 's/|$//' $i > ${i/tbl/csv}
done

mkdir -p ${ROOT}/data
mv *.csv ${ROOT}/data/
unlink /tmp/dss-data
ln -s ${ROOT}/data /tmp/dss-data

popd
