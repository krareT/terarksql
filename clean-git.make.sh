
set -e
set -x

base=$PWD/clean-git
BMI2=`sed '/^BMI2=/!d;s/.*=//' $base/make.config`

if [ $BMI2 = '0' ];then
	CPU_FLAG="CPU=-march=corei7"
fi

cd $base/snappy
./configure \
	--prefix=$PWD/package-dir \
	--enable-shared=no \
	--enable-static=yes \
	--enable-gtest=no \
	--with-gflags=no
make -j8
make install

cd $base/rocksdb
git checkout next_gen .

cd $base/terark
git checkout master .
make pkg -j32 $CPU_FLAG WITH_BMI2=$BMI2 PKG_WITH_DBG=1 PKG_WITH_STATIC=1 PKG_WITH_EXE=0 BOOST_INC=-I$base/boost-pkg

cd $base/terark-zip-rocksdb
git checkout next_gen .
make pkg -j32 $CPU_FLAG WITH_BMI2=$BMI2 PKG_WITH_DBG=1 PKG_WITH_STATIC=1 PKG_WITH_EXE=0 BOOST_INC=-I$base/boost-pkg

#cd $base/tbb

cd $base/mysql-5.6
git checkout fb-mysql-5.6.35.20181130.terark .
rm -rf rocksdb
ln -s ../rocksdb .
mkdir -p build && cd build
sh -x ../run-cmake.sh
make -j32
