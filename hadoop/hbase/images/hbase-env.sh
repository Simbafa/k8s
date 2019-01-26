export HBASE_CLASSPATH=/hbase/conf
export HBASE_MANAGES_ZK=false
export HBASE_HOME=/hbase
export HBASE_LOG_DIR=/hbase/logs

#kerberos
export JAAS_CONF=/hbase/conf/zk-jaas.conf
export HBASE_OPTS="$HBASE_OPTS -Djava.security.auth.login.config=$JAAS_CONF"
export HBASE_MASTER_OPTS="-Djava.security.auth.login.config=$JAAS_CONF"
export HBASE_REGIONSERVER_OPTS="-Djava.security.auth.login.config=$JAAS_CONF"
