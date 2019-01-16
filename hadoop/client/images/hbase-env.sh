export JAVA_HOME=/usr/local/jdk1.8.0_191
export HBASE_CLASSPATH=/usr/local/hbase/conf
export HBASE_MANAGES_ZK=false
export HBASE_HOME=/usr/local/hbase
export HBASE_LOG_DIR=/usr/local/hbase/logs

#kerberos
export JAAS_CONF=/usr/local/hbase/conf/zk-jaas.conf
export HBASE_OPTS="$HBASE_OPTS -Djava.security.auth.login.config=$JAAS_CONF"
export HBASE_MASTER_OPTS="-Djava.security.auth.login.config=$JAAS_CONF"
export HBASE_REGIONSERVER_OPTS="-Djava.security.auth.login.config=$JAAS_CONF"
