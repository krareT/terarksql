#!/bin/sh

cd mysql-5.6/build
# make && install
echo "start make && install..."
make -j32
make install -j8
sh -x ../post-make-install.sh
echo "-- make done"

# mv package to ci_build
rm -rf $BASE/mysql-package
rm -rf $BASE/mysql-data
# init
echo "start init..."
mv __MYSQL_INSTALL_DIR__ $BASE/mysql-package
sh -x $BASE/mysql-package/init.sh prepare $BASE/mysql-data
sh -x $BASE/mysql-package/init.sh init
echo "-- init done"

