#!/bin/sh

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

