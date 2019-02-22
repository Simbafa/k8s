#!/bin/bash

if [ -f "/etc/hadoop/fromhost/pre-run.sh" ]; then
    source /etc/hadoop/fromhost/pre-run.sh
fi

. /etc/hadoop/hadoop-env.sh
. /libexec/yarn-config.sh
. /usr/local/spark/conf/spark-env.sh
. /usr/local/hive/conf/hive-env.sh
export SPARK_DIST_CLASSPATH=$(hadoop classpath)

kinit -kt /etc/hadoop/hdfs.keytab root/namenode@JUSTEP.COM
klist 

sed "s/HDFSNAMENODERPC_SERVICE_HOST/$HDFSNAMENODERPC_SERVICE_HOST/;s/HDFSNAMENODERPC_SERVICE_PORT/$HDFSNAMENODERPC_SERVICE_PORT/;s/LDAP_HOST/$LDAP_HOST/" /etc/hadoop/core-site.xml.template > /etc/hadoop/core-site.xml
cat /etc/hadoop/core-site.xml

sed -i "s/JOBHISTORY_ADDRESS/$JOBHISTORY_ADDRESS/;s/JOBHISTORY_WEBAPP_ADDRESS/$JOBHISTORY_WEBAPP_ADDRESS/" /etc/hadoop/mapred-site.xml
sed -i "s/MY_MEM_LIMIT/$MY_MEM_LIMIT/;s/MY_CPU_LIMIT/$MY_CPU_LIMIT/" /etc/hadoop/yarn-site.xml
sed -i "s/LDAP_HOST/$LDAP_HOST/" /usr/local/hive/conf/hive-site.xml

# log dir
mkdir -p /data/hadoop-log-dir
mkdir -p /data/yarn-log-dir

echo "Start installing ldap......"
#/install_ldap.sh
/etc/init.d/nscd restart  

cd /etc/hadoop/fromhost
# initSchema
if [ ! -f /etc/hadoop/fromhost/hive_metastore_initialized ]; then
   $HADOOP_HOME/bin/hadoop fs -mkdir -p /tmp
   $HADOOP_HOME/bin/hadoop fs -mkdir -p /user/hive/warehouse
   $HADOOP_HOME/bin/hadoop fs -chmod -R 777 /tmp
   $HADOOP_HOME/bin/hadoop fs -chmod -R 711 /user/hive
   $HADOOP_HOME/bin/hadoop fs -chown -R hive /user/hive
   $HIVE_HOME/bin/schematool -dbType mysql -initSchema --verbose &> /etc/hadoop/fromhost/hive_metastore_initialized
fi

kinit -kt /usr/local/hive/conf/hive.keytab hive/hive@JUSTEP.COM
klist 

$HIVE_HOME/bin/hive --service metastore &
$HIVE_HOME/bin/hive --service hiveserver2 --hiveconf hive.mapred.mode=strict --hiveconf hive.orc.cache.stripe.details.size=1000 --hiveconf mapred.reduce.tasks=64 --hiveconf hive.server2.active.passive.ha.enable=true

# test
# ./bin/beeline -u "jdbc:hive2://localhost:10000" -n hive -p hive
