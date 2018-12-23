#!/bin/bash

if [ -f "/opt/zookeeper/fromhost/pre-run.sh" ]; then
    source /opt/zookeeper/fromhost/pre-run.sh
fi

sed -i "s!SERVER_PRINCIPAL!$SERVER_PRINCIPAL!g" /opt/zookeeper/conf/jaas.conf

kinit -kt /opt/zookeeper/conf/zookeeper.keytab root/namenode@JUSTEP.COM
klist 

echo "Start installing ldap......"
/install_ldap.sh

export JVMFLAGS="-Djava.security.auth.login.config=/opt/zookeeper/conf/jaas.conf"

echo "$SERVER_ID / $MAX_SERVERS" 
if [ ! -z "$SERVER_ID" ] && [ ! -z "$MAX_SERVERS" ]; then
  echo "Starting up in clustered mode"
  echo "" >> /opt/zookeeper/conf/zoo.cfg
  echo "#Server List" >> /opt/zookeeper/conf/zoo.cfg
  for i in $( eval echo {1..$MAX_SERVERS});do
    HostEnv="ZOOKEEPER_${i}_SERVICE_HOST"
    HOST=${!HostEnv}
    FollowerPortEnv="ZOOKEEPER_${i}_SERVICE_PORT_FOLLOWERS"
    FOLLOWERPORT=${!FollowerPortEnv}
    ElectionPortEnv="ZOOKEEPER_${i}_SERVICE_PORT_ELECTION"
    ELECTIONPORT=${!ElectionPortEnv}
    if [ "$SERVER_ID" = "$i" ];then
      echo "server.$i=0.0.0.0:$FOLLOWERPORT:$ELECTIONPORT" >> /opt/zookeeper/conf/zoo.cfg
    else
      echo "server.$i=$HOST:$FOLLOWERPORT:$ELECTIONPORT" >> /opt/zookeeper/conf/zoo.cfg
    fi
  done
  cat /opt/zookeeper/conf/zoo.cfg

  # Persists the ID of the current instance of Zookeeper
  echo ${SERVER_ID} > /opt/zookeeper/data/myid
  else
      echo "Starting up in standalone mode"
fi

exec /opt/zookeeper/bin/zkServer.sh start-foreground
