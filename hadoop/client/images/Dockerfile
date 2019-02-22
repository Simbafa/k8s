
# docker build -t hub.cloudx5.com/justep/hadoop-client:1.0.0 . 

FROM ubuntu:18.04

USER root

RUN export DEBIAN_FRONTEND=noninteractive && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y -q curl krb5-user libpam-krb5 libpam-ccreds vim libcap2 net-tools iputils-ping iproute2 openssh-server

RUN sed -i s/#PubkeyAuthentication.*/PubkeyAuthentication\ yes/ /etc/ssh/sshd_config && \
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config

RUN apt-get install -y openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME=$JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ADD local_policy.jar $JAVA_HOME/jre/lib/security/local_policy.jar
ADD US_export_policy.jar $JAVA_HOME/jre/lib/security/US_export_policy.jar

RUN curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/hadoop-2.9.2.tar.gz | tar -xzf - -C /usr/local
RUN mv /usr/local/hadoop-2.9.2 /usr/local/hadoop
ADD commons-daemon-1.1.0.jar /usr/local/hadoop/share/hadoop/hdfs/lib/commons-daemon-1.1.0.jar
ADD core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop


ENV HBASE_VERSION 1.4.9
ENV HBASE_INSTALL_DIR /usr/local/hbase
RUN mkdir -p ${HBASE_INSTALL_DIR} && \
    curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/hbase-${HBASE_VERSION}-bin.tar.gz | \
    tar -xz --strip=1 -C ${HBASE_INSTALL_DIR}
ADD core-site.xml  ${HBASE_INSTALL_DIR}/conf/core-site.xml
ADD hbase-env.sh   ${HBASE_INSTALL_DIR}/conf/hbase-env.sh
ADD hbase-site.xml ${HBASE_INSTALL_DIR}/conf/hbase-site.xml

RUN curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/spark-1.6.3-bin-hadoop2.4-without-hive.tgz | tar -xzf - -C /
RUN mv /spark-1.6.3-bin-hadoop2.4-without-hive /usr/local/spark
ADD spark-env.sh /usr/local/spark/conf/spark-env.sh

RUN curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/apache-hive-2.1.1-bin.tar.gz | tar -xzf - -C /
RUN mv /apache-hive-2.1.1-bin /usr/local/hive
ENV HIVE_HOME=/usr/local/hive
ENV HIVE_CONF_DIR=/usr/local/hive/conf
ADD hive-env.sh /usr/local/hive/conf/hive-env.sh

RUN ldconfig
ADD krb5.conf /etc/krb5.conf
ADD install_ldap.sh /install_ldap.sh
RUN chmod +x /install_ldap.sh
RUN /install_ldap.sh
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:/usr/local/hadoop/bin
ENV PATH $PATH:/usr/local/hbase/bin
ENV PATH $PATH:/usr/local/hive/bin

WORKDIR /usr/local

# -Dsun.security.krb5.debug=true
ADD README /
ADD bootstrap.sh /bootstrap.sh
RUN chmod a+x /bootstrap.sh
ENTRYPOINT /bootstrap.sh 

ADD env.sh /env.sh
RUN chmod a+x /env.sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo "" >> /etc/profile
RUN echo "source /env.sh" >> /etc/profile
RUN echo 'root:justep@2' | chpasswd

EXPOSE 22

