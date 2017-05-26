#!/usr/bin/env bash

GCC_DIR=/ssd/terark/gcc-4.8
ZLIB_DIR=/ssd/terark/zlib-1.2.11
GLIBC_DIR=/ssd/terark/glibc-2.14
export WITH_TERARKDB=/ssd/terark/src/terark-zip-rocksdb
#export LD_LIBRARY_PATH=$WITH_TERARKDB/lib:$GCC_DIR/lib64:/usr/lib:/usr/lib64

set -x
cd mysql-5.6
mkdir -p build
cd build
if [ -z "$1" ] || [ "$1" == "cmake" ]; then
	/ssd/terark/cmake-2.8/bin/cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_SSL=system \
	-DWITH_ZLIB=$ZLIB_DIR/lib -DMYSQL_MAINTAINER_MODE=0 \
	-DENABLED_LOCAL_INFILE=1 -DENABLE_DTRACE=0 \
	-DCMAKE_INSTALL_PREFIX=/ssd/terark/mysql-on-terarkdb \
	-DCMAKE_C_COMPILER=$GCC_DIR/bin/gcc \
	-DCMAKE_CXX_COMPILER=$GCC_DIR/bin/g++ \
	-DMYSQL_GITHASH=empty \
        -DMYSQL_GITDATE=empty \
        -DROCKSDB_GITHASH=empty \
        -DROCKSDB_GITDATE=empty \
	-DCMAKE_C_FLAGS="-L$GLIBC_DIR/lib" \
	-DCMAKE_CXX_FLAGS="-L$GLIBC_DIR/lib"

fi
if [ -z "$1" ] || [ "$1" == "make" ]; then
	make $2
fi
