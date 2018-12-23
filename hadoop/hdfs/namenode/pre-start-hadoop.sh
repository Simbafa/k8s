
if [ -f "/etc/hadoop/fromhost/pre-run.sh" ]; then
    source /etc/hadoop/fromhost/pre-run.sh
fi

# gen core-site.xml，need install ip tools
sed s/HOSTNAME/$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')/ /etc/hadoop/core-site.xml.template > /etc/hadoop/core-site.xml
cat /etc/hadoop/core-site.xml

# log dir
mkdir -p /data/hadoop-log-dir

kinit -kt /etc/hadoop/hdfs.keytab root/namenode@JUSTEP.COM

echo "Start installing ldap......"
/install_ldap.sh

# start all JournalNode,  NameNode and JournalNode  in same pod
/sbin/hadoop-daemon.sh start journalnode

CLUSTER_ID=CID-920897d7-51bf-43c7-9766-443e9aefe878
if [ ! -d /data/nn/current ]; then
  mkdir -p /data/nn
  chmod 700 /data/nn
  sudo -u root hdfs namenode -format -clusterId $CLUSTER_ID # always format with the same cluster id，use root user，before start HDFS，need to format NameNode
fi

