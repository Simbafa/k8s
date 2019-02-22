#!/bin/bash

if [ -f "/etc/hadoop/fromhost/pre-run.sh" ]; then
    source /etc/hadoop/fromhost/pre-run.sh
fi

. /etc/hadoop/hadoop-env.sh
. /usr/local/spark/conf/spark-env.sh

kinit -kt /etc/hadoop/yarn.keytab root/yarn-nm@JUSTEP.COM
klist 

sed "s/HDFSNAMENODERPC_SERVICE_HOST/$HDFSNAMENODERPC_SERVICE_HOST/;s/HDFSNAMENODERPC_SERVICE_PORT/$HDFSNAMENODERPC_SERVICE_PORT/" /etc/hadoop/core-site.xml.template > /etc/hadoop/core-site.xml
cat /etc/hadoop/core-site.xml

sed -i "s/JOBHISTORY_ADDRESS/$JOBHISTORY_ADDRESS/;s/JOBHISTORY_WEBAPP_ADDRESS/$JOBHISTORY_WEBAPP_ADDRESS/" /etc/hadoop/mapred-site.xml
sed -i "s/MY_MEM_LIMIT/$MY_MEM_LIMIT/;s/MY_CPU_LIMIT/$MY_CPU_LIMIT/" /etc/hadoop/yarn-site.xml

# log dir
mkdir -p /data/hadoop-log-dir
mkdir -p /data/yarn-log-dir

echo "Start installing ldap......"
#/install_ldap.sh
/etc/init.d/nscd restart  

chmod 644 /etc/hadoop/*
. /libexec/yarn-config.sh
/sbin/yarn-daemon.sh --config $YARN_CONF_DIR  start nodemanager

until find /data/yarn-log-dir -mmin -1 | egrep -q '.*'; echo "`date`: Waiting for logs..." ; do sleep 2 ; done
tail -F /data/yarn-log-dir/* &
while true; do sleep 1000; done
