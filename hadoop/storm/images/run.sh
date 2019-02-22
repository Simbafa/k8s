#!/bin/bash

if [ ! -f /usr/local/apache-storm/conf/storm.yaml ]
then
	echo "Starting with an empty storm configuration file"
    sed "s/ZOOKEEPER_SERVERS/$ZOOKEEPER_SERVERS/;s/NIMBUS_SEEDS/$NIMBUS_SEEDS/" /storm.yaml > /usr/local/apache-storm/conf/storm.yaml
fi

if [ "x$STORM_CMD" != "x" ]
then
	echo "Running storm command ${STORM_CMD}"
	storm ${STORM_CMD}

else
	echo "Nothing to run. Just waiting..."
	while true; do sleep 3; done
fi

