#!/bin/bash

export SPARK_DIST_CLASSPATH=$(hadoop classpath)
export HBASE_CONF_FILE=/hbase/conf/hbase-site.xml
export HBASE_MANAGES_ZK=false

. /usr/local/hadoop/etc/hadoop/hadoop-env.sh
. /usr/local/spark/conf/spark-env.sh
. /usr/local/hive/conf/hive-env.sh
. /usr/local/hbase/conf/hbase-env.sh
. /libexec/yarn-config.sh

/etc/init.d/nscd restart  

while true; do sleep 1000; done

