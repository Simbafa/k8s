
# docker build -t hub.cloudx5.com/justep/hadoop-hbase:1.0.0 . 

FROM hub.cloudx5.com/justep/hadoop-base:1.0.0

# 这里要去https://mirrors.tuna.tsinghua.edu.cn/apache/hbase看看有什么版本的
ENV HBASE_VERSION 1.4.9
ENV HBASE_INSTALL_DIR /hbase

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 下载解压hbase到指定目录
RUN mkdir -p ${HBASE_INSTALL_DIR} && \
    curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/hbase-${HBASE_VERSION}-bin.tar.gz | \
    tar -xz --strip=1 -C ${HBASE_INSTALL_DIR}

# 复制配置文件进入
ADD hbase-site.xml /hbase/conf/hbase-site.xml
ADD hbase-env.sh /hbase/conf/hbase-env.sh

ADD hbase.keytab /hbase/conf/hbase.keytab
ADD zk-jaas.conf /hbase/conf/zk-jaas.conf
ADD core-site.xml /hbase/conf/core-site.xml
ADD hdfs-site.xml /hbase/conf/hdfs-site.xml
ADD local_policy.jar $JAVA_HOME/jre/lib/security/local_policy.jar
ADD US_export_policy.jar $JAVA_HOME/jre/lib/security/US_export_policy.jar

ADD start-k8s-hbase.sh /hbase/bin/start-k8s-hbase.sh
RUN chmod +x /hbase/bin/start-k8s-hbase.sh
#RUN cp /hbase/lib/client-facing-thirdparty/htrace-core* /hbase/lib/

WORKDIR /hbase/bin

ENV PATH=$PATH:/hbase/bin

CMD /usr/bin/supervisord
