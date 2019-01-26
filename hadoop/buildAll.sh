#!/bin/sh

set -e

CURRENT_DIR=`dirname $(readlink -f $0)`

cd $CURRENT_DIR/hdfs
./build.sh 1.0.0 true

cd $CURRENT_DIR/hdfs/namenode
./build.sh 1.0.0 true
cd $CURRENT_DIR/hdfs/datanode
./build.sh 1.0.0 true

cd $CURRENT_DIR/yarn/images/resoucemanager
./build.sh 1.0.0 true
cd $CURRENT_DIR/yarn/images/nodemanager
./build.sh 1.0.0 true
cd $CURRENT_DIR/yarn/images/nodemanager/spark
./build.sh 1.0.0 true

cd $CURRENT_DIR/hbase/images
./build.sh 1.0.0 true

cd $CURRENT_DIR/zookeeper/images
./build.sh 1.0.0 true

cd $CURRENT_DIR/hive/images
./build.sh 1.0.0 true

cd $CURRENT_DIR/client/images
./build.sh 1.0.0 true

docker rmi $(docker images | grep "<none>" | awk '{print $3}')
