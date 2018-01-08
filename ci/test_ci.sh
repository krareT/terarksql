#!/bin/bash

BASE=/ci_build

rm -rf /oldssd1/ci/tempvar/*
rm -rf /oldssd1/ci/mysql-data/terark-temp/*

cd $BASE/mysql-package/mysql-test
./mysql-test-run.pl --vardir=/oldssd1/ci/tempvar --async-client --parallel=8 --fast --max-test-fail=1000 --retry=0 --force --mysqld=--rocksdb --mysqld=--default-storage-engine=rocksdb --mysqld=--skip-innodb --mysqld=--default-tmp-storage-engine=MyISAM --suite=rocksdb --retry-failure=3 --mysqld-env=TerarkZipTable_localTempDir=/oldssd1/ci/mysql-data/terark-temp --mysqld-env=TerarkZipTable_keyPrefixLen=4 --mysqld-env=TerarkZipTable_disableFewZero=true --mysqld-env=TerarkUseDivSufSort=1 --testcase-timeout=30


