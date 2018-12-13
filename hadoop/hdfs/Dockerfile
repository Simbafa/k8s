# docker build -t hub.cloudx5.com/justep/hadoop-base:1.0.0 .

FROM ubuntu:18.04

USER root

# tools
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl sudo supervisor krb5-user libpam-krb5 libpam-ccreds jsvc vim libcap2

# 先去下载http://www.oracle.com/technetwork/java/javase/downloads/index.html
ADD jdk-8u191-linux-x64.tar.gz /usr/local/

# 自己先解压一遍看看。export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_191    source /etc/profile
ENV JAVA_HOME /usr/local/jdk1.8.0_191
ENV JRE_HOME=$JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# install hadoop，在https://archive.apache.org/dist/hadoop//下载
ADD hadoop-2.7.3.tar.gz /
RUN cp -rf /hadoop-2.7.3/* /
RUN rm -rf /hadoop-2.7.3
RUN ldconfig
ADD commons-daemon-1.1.0.jar /share/hadoop/hdfs/lib/commons-daemon-1.1.0.jar
ADD hdfs.keytab /etc/hadoop/hdfs.keytab
ADD krb5.conf /etc/krb5.conf

ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $PATH:/bin

