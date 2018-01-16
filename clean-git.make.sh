
set -e
set -x

base=$PWD

cd $base/clean-git/snappy
git checkout .
./configure \
	--prefix=$PWD/package-dir \
	--enable-shared=no \
	--enable-static=yes \
	--enable-gtest=no \
	--with-gflags=no
make -j8
make install

cd $base/clean-git/rocksdb
git checkout 5.9.fb.myrocks.terark.dev .

cd $base/clean-git/terark
git checkout .
make pkg -j32 PKG_WITH_DBG=1 PKG_WITH_STATIC=1

cd $base/clean-git/terark-zip-rocksdb
git checkout .
make pkg -j32 PKG_WITH_DBG=1 PKG_WITH_STATIC=1

#cd $base/clean-git/tbb

cd $base/clean-git/mysql-5.6
git checkout fb-mysql-5.6.35.r2017.q4.terark .
rm -rf rocksdb
ln -s ../rocksdb .
mkdir -p build && cd build
sh -x ../run-cmake.sh
make -j32
