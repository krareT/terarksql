
set -e
set -x

base=$PWD
rm -rf clean-git
mkdir clean-git
cd $base/clean-git
mkdir -p mysql-5.6 terark/3rdparty terark-zip-rocksdb snappy rocksdb

cp -r $base/terark/.git             $base/clean-git/terark/
cp -r $base/terark/3rdparty/xxHash  $base/clean-git/terark/3rdparty/
cp -r $base/terark/3rdparty/base64  $base/clean-git/terark/3rdparty/
cp -r $base/terark-zip-rocksdb/.git $base/clean-git/terark-zip-rocksdb/
cp -r $base/snappy/.git             $base/clean-git/snappy/
cp -r $base/rocksdb/.git            $base/clean-git/rocksdb/
cp -r $base/mysql-on-terarkdb/.git/modules/mysql-5.6  $base/clean-git/mysql-5.6/.git
sed -i "/worktree/d"                                  $base/clean-git/mysql-5.6/.git/config

rm -rf $base/clean-git/mysql-5.6/rocksdb
cd     $base/clean-git/mysql-5.6
ln -s ../rocksdb .

#cd $base/clean-git
#tar xzf ../tbb-2018_U1.tgz
#mv tbb-2018_U1 tbb

cd $base/clean-git/snappy
git checkout .
sh autogen.sh

cp $base/mysql-on-terarkdb/clean-git*.sh clean-git/

tar czf clean-git.tgz clean-git

