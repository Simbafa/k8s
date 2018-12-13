
# docker build -t hub.cloudx5.com/justep/hadoop-hbase:1.0.0 . 

FROM java:8

# 这里要去https://mirrors.tuna.tsinghua.edu.cn/apache/hbase看看有什么版本的
ENV HBASE_VERSION 2.1.1
ENV HBASE_INSTALL_DIR /hbase
# 配置环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# 安装supervisor为了能以前台的方式运行hbase。(supervisor在前台，hbase在后台)
RUN apt-get update -y && apt-get install --no-install-recommends -y supervisor vim
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 下载解压hbase到指定目录
RUN mkdir -p ${HBASE_INSTALL_DIR} && \
    curl -L https://mirrors.tuna.tsinghua.edu.cn/apache/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz | \
    tar -xz --strip=1 -C ${HBASE_INSTALL_DIR}

# 复制配置文件进入
ADD hbase-site.xml /hbase/conf/hbase-site.xml
ADD hbase-env.sh /hbase/conf/hbase-env.sh

ADD hbase.keytab /hbase/conf/hbase.keytab
ADD zk-jaas.conf /hbase/conf/zk-jaas.conf
ADD core-site.xml /hbase/conf/core-site.xml
ADD hdfs-site.xml /hbase/conf/hdfs-site.xml
ADD local_policy.jar /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/security/local_policy.jar
ADD US_export_policy.jar /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/security/US_export_policy.jar

ADD start-k8s-hbase.sh /hbase/bin/start-k8s-hbase.sh
RUN chmod +x /hbase/bin/start-k8s-hbase.sh

WORKDIR /hbase/bin

ENV PATH=$PATH:/hbase/bin

CMD /usr/bin/supervisord
