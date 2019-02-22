#!/bin/bash

export SPARK_DIST_CLASSPATH=$(hadoop classpath)
export HBASE_CONF_FILE=/hbase/conf/hbase-site.xml
export HBASE_MANAGES_ZK=false

. /usr/local/hadoop/etc/hadoop/hadoop-env.sh
. /usr/local/spark/conf/spark-env.sh
. /usr/local/hive/conf/hive-env.sh
. /usr/local/hbase/conf/hbase-env.sh
. /libexec/yarn-config.sh
. /env.sh

/etc/init.d/nscd start  
/etc/init.d/ssh start

for i in ${HBASE_LIST[@]}
do
   arr=(${i//:/ })
   echo "${arr[0]} ${arr[1]}" >> /etc/hosts
done


while true; do sleep 1000; done

