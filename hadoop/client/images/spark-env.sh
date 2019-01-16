#!/usr/bin/env bash

export JAVA_HOME="/usr/local/jdk1.8.0_191"
export SPARK_HOME="/usr/local/spark"
export SCALA_HOME="/usr/local/scala"
export HADOOP_HOME=""
export HADOOP_CONF_DIR="/etc/hadoop"
export YARN_CONF_DIR="/etc/hadoop"
export SPARK_DIST_CLASSPATH=$(hadoop classpath)
SPARK_LOCAL_DIRS="/data/spark"
SPARK_DRIVER_MEMORY=1G
export SPARK_LIBARY_PATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$HADOOP_HOME/lib/native
export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SCALA_HOME/bin
