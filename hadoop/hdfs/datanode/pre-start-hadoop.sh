
if [ -f "/etc/hadoop/fromhost/pre-run.sh" ]; then
    source /etc/hadoop/fromhost/pre-run.sh
fi

# gen core-site.xml
sed "s/HDFSNAMENODERPC_SERVICE_HOST/$HDFSNAMENODERPC_SERVICE_HOST/;s/HDFSNAMENODERPC_SERVICE_PORT/$HDFSNAMENODERPC_SERVICE_PORT/" /etc/hadoop/core-site.xml.template > /etc/hadoop/core-site.xml
cat /etc/hadoop/core-site.xml

# log dir
mkdir -p /data/hadoop-log-dir

# create datanode if not exist
if [ ! -d /data/dn/current ]; then
  mkdir -p /data/dn
  chmod 700 /data/dn
fi

kinit -kt /etc/hadoop/hdfs.keytab root/datanode@JUSTEP.COM

