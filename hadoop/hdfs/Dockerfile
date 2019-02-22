# docker build -t hub.cloudx5.com/justep/hadoop-base:1.0.0 .

FROM ubuntu:18.04

USER root

# tools
RUN export DEBIAN_FRONTEND=noninteractive && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y -q wget curl sudo supervisor krb5-user libpam-krb5 libpam-ccreds jsvc vim libcap2 net-tools iputils-ping iproute2

RUN apt-get install -y openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME=$JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# install hadoop，在https://archive.apache.org/dist/hadoop//下载
RUN curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/hadoop-2.9.2.tar.gz | tar -xzf - -C /
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

