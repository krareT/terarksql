#!/bin/sh

set -x
set -e

BASE=/ci_build

# set rocksdb
cd mysql-5.6
if [ ! -d rocksdb ]; then
    ln -s $BASE/rocksdb ./rocksdb
fi

# set core pkg
PKG=$BASE/terark-zip-rocksdb/terark-zip-rocksdb-Linux-x86_64-g++-4.8-bmi2-0
if [ ! -d "$PKG" ]; then
    echo "$PKG" "doesn't exist"
    exit -1
fi
cp -r $BASE/terark-core/terark-fsa_all-Linux-x86_64-g++-4.8-bmi2-0/lib/*.a $PKG/lib_static

# cmake within build/
echo "start cmake..."
rm -rf build
mkdir build
cd build

ln -s $PKG terark-zip-rocksdb-pkg
btype=MinSizeRel
#btype=Release
btype=RelWithDebInfo
#btype=Debug
cmake .. \
 -DCMAKE_VERBOSE_MAKEFILE=ON \
 -DCMAKE_SKIP_BUILD_RPATH=ON \
 -DCMAKE_SKIP_INSTALL_RPATH=ON \
 -DCMAKE_BUILD_TYPE=$btype \
 -DWITH_SSL=system \
 -DWITH_ZLIB=bundled \
 -DWITH_SNAPPY=/opt/gcc-4.8 \
 -DWITH_TERARKDB=${PWD}/terark-zip-rocksdb-pkg \
 -DMYSQL_MAINTAINER_MODE=0 \
 -DENABLED_LOCAL_INFILE=1 \
 -DENABLE_DTRACE=0 \
 -DCMAKE_INSTALL_PREFIX=__MYSQL_INSTALL_DIR__
echo "-- cmake done"

# make && install
echo "start make && install..."
make -j32
rm -rf __MYSQL_INSTALL_DIR__
rm -rf packageRoot
rm -rf databaseDir
make install -j8
sh -x ../post-make-install
echo "-- make done"

# mv package to ci_build
#rm -rf $BASE/mysql-package
#rm -rf $BASE/mysql-data

#rm -rf packageRoot
#mv __MYSQL_INSTALL_DIR__ packageRoot

#sh -x packageRoot/init.sh prepare databaseDir
#sh -x packageRoot/init.sh init

#echo "-- install done"

