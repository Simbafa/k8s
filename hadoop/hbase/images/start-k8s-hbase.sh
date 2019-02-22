#!/bin/bash

if [ "$HBASE_SERVER_TYPE" = "master" ]; then
   kinit -kt /hbase/conf/hbase.keytab root/hbase-master-1@JUSTEP.COM
elif [ "$HBASE_SERVER_TYPE" = "regionserver" ]; then
   kinit -kt /hbase/conf/hbase.keytab root/hbase-region-1@JUSTEP.COM
fi
klist 

if [ -f "/hbase/fromhost/pre-run.sh" ]; then
    source /hbase/fromhost/pre-run.sh
fi

export HBASE_CONF_FILE=/hbase/conf/hbase-site.xml
export HADOOP_USER_NAME=root
export HBASE_MANAGES_ZK=false

sed -i "s/@HBASE_MASTER_PORT@/$HBASE_MASTER_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HBASE_MASTER_INFO_PORT@/$HBASE_MASTER_INFO_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HBASE_REGION_PORT@/$HBASE_REGION_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HBASE_REGION_INFO_PORT@/$HBASE_REGION_INFO_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HDFS_PATH@/$HDFS_SERVICE:$HDFS_PORT/g" $HBASE_CONF_FILE
sed -i "s/@ZOOKEEPER_IP_LIST@/$ZOOKEEPER_SERVICE_LIST/g" $HBASE_CONF_FILE
sed -i "s/@ZOOKEEPER_PORT@/$ZOOKEEPER_PORT/g" $HBASE_CONF_FILE
sed -i "s/@ZNODE_PARENT@/$ZNODE_PARENT/g" $HBASE_CONF_FILE

for i in ${HBASE_MASTER_LIST[@]}
do
   arr=(${i//:/ })
   echo "${arr[0]} ${arr[1]}" >> /etc/hosts
done

for i in ${HBASE_REGION_LIST[@]}
do
   arr=(${i//:/ })
   echo "${arr[0]} ${arr[1]}" >> /etc/hosts
done

echo "Start installing ldap......"
#/install_ldap.sh
/etc/init.d/nscd restart  

##启动master和region在同一个node上，尽在master节点上启动即可，会自动寻找
#if [ "$MASTER_DEBUG" == "no" ]; then
#    /hbase/bin/start-hbase.sh    # 会自动后台启动master和regionserver
#    if [ "$START_THRIFT" == "yes" ]; then
#       /hbase/bin/hbase-daemon.sh start thrift   #  会后台启动thrift，以便python接入
#    fi
#fi

# 下面是master和regionserver分开部署的方式
if [ "$HBASE_SERVER_TYPE" = "master" ]; then
 
   if [ "$MASTER_DEBUG" == "no" ]; then
      /hbase/bin/hbase master start > logmaster.log 2>&1
      if [ "$START_THRIFT" == "yes" ]; then
          echo "Start thrift server"
          /hbase/bin/hbase-daemon.sh start thrift > logthrift.log 2>&1
          #/hbase/bin/hbase-daemons.sh start thrift2 > logthrift.log 2>&1
      fi
   fi
elif [ "$HBASE_SERVER_TYPE" = "regionserver" ]; then
    /hbase/bin/hbase regionserver start > logregion.log 2>&1
fi



