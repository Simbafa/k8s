#!/bin/sh

CURRENT_DIR=`dirname $(readlink -f $0)`

cd $CURRENT_DIR/hdfs
./build.sh true

cd $CURRENT_DIR/hdfs/namenode
./build.sh true
cd $CURRENT_DIR/hdfs/datanode
./build.sh true

cd $CURRENT_DIR/yarn/images/resoucemanager
./build.sh true
cd $CURRENT_DIR/yarn/images/nodemanager
./build.sh true
cd $CURRENT_DIR/yarn/images/nodemanager/spark
./build.sh true

cd $CURRENT_DIR/hbase/images
./build.sh true

cd $CURRENT_DIR/zookeeper/images
./build.sh true

docker rmi $(docker images | grep "<none>" | awk '{print $3}')
