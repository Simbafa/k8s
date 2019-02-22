#!/bin/bash

if [ -f "/etc/hadoop/fromhost/pre-run.sh" ]; then
    source /etc/hadoop/fromhost/pre-run.sh
fi

. /etc/hadoop/hadoop-env.sh
. /usr/local/spark/conf/spark-env.sh
. /usr/local/hive/conf/hive-env.sh

kinit -kt /etc/hadoop/hdfs.keytab root/datanode@JUSTEP.COM
klist 

sed "s/HDFSNAMENODERPC_SERVICE_HOST/$HDFSNAMENODERPC_SERVICE_HOST/;s/HDFSNAMENODERPC_SERVICE_PORT/$HDFSNAMENODERPC_SERVICE_PORT/;s/LDAP_HOST/$LDAP_HOST/" /etc/hadoop/core-site.xml.template > /etc/hadoop/core-site.xml
cat /etc/hadoop/core-site.xml

sed -i "s/JOBHISTORY_ADDRESS/$JOBHISTORY_ADDRESS/;s/JOBHISTORY_WEBAPP_ADDRESS/$JOBHISTORY_WEBAPP_ADDRESS/" /etc/hadoop/mapred-site.xml
sed -i "s/MY_MEM_LIMIT/$MY_MEM_LIMIT/;s/MY_CPU_LIMIT/$MY_CPU_LIMIT/" /etc/hadoop/yarn-site.xml
sed -i "s/LDAP_HOST/$LDAP_HOST/" /usr/local/hive/conf/hive-site.xml

# log dir
mkdir -p /data/hadoop-log-dir
mkdir -p /data/yarn-log-dir
mkdir -p /data/sqoop-log-dir

echo "Start installing ldap......"
/install_ldap.sh

echo "starting sqoop2 server"
sqoop2-server start

exec tail -f /data/sqoop-log-dir/sqoop.log
