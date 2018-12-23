export JAVA_HOME=/usr/local/jdk1.8.0_191
export HBASE_CLASSPATH=/hbase/conf
export HBASE_MANAGES_ZK=false
export HBASE_HOME=/hbase
export HBASE_LOG_DIR=/hbase/logs

#kerberos
export HBASE_OPTS="$HBASE_OPTS -Djava.security.auth.login.config=/hbase/conf/zk-jaas.conf"
