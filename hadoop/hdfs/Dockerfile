# docker build -t hub.cloudx5.com/justep/hadoop-base:1.0.0 .

FROM ubuntu:18.04

USER root

# tools
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get install -y -q wget curl sudo supervisor krb5-user libpam-krb5 libpam-ccreds jsvc vim libcap2 net-tools iputils-ping iproute2

# 先去下载http://www.oracle.com/technetwork/java/javase/downloads/index.html
ADD jdk-8u191-linux-x64.tar.gz /usr/local/

# 自己先解压一遍看看。export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_191    source /etc/profile
ENV JAVA_HOME /usr/local/jdk1.8.0_191
ENV JRE_HOME=$JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# install hadoop，在https://archive.apache.org/dist/hadoop//下载
ADD hadoop-2.9.2.tar.gz /
RUN cp -rf /hadoop-2.9.2/* /
RUN rm -rf /hadoop-2.9.2
RUN ldconfig
ADD commons-daemon-1.1.0.jar /share/hadoop/hdfs/lib/commons-daemon-1.1.0.jar
ADD hdfs.keytab webhdfs.keytab /etc/hadoop/
ADD krb5.conf /etc/krb5.conf

#COPY common-account common-auth common-password common-session common-session-noninteractive /etc/pam.d/
#COPY ldap.conf nsswitch.conf /etc/
#COPY ldap.conf2 /etc/ldap/ldap.conf

ADD install_ldap.sh /install_ldap.sh
RUN chmod +x /install_ldap.sh
RUN /install_ldap.sh
ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $PATH:/bin

