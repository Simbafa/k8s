# docker build -t hub.cloudx5.com/justep/hbase-zookeeper:1.0.0 .

FROM hub.cloudx5.com/justep/hadoop-base:1.0.0

USER root

ENV ZOOKEEPER_VERSION 3.4.10
EXPOSE 2181 2888 3888

RUN curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-${ZOOKEEPER_VERSION} /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /opt/zookeeper/{data,log}

WORKDIR /opt/zookeeper
VOLUME ["/opt/zookeeper/conf", "/opt/zookeeper/data", "/opt/zookeeper/log"]

COPY config-and-run.sh ./bin/
COPY zoo.cfg ./conf/
COPY zookeeper.keytab ./conf/
COPY krb5.conf /etc/
COPY jaas.conf ./conf/
RUN chmod +x ./bin/config-and-run.sh

CMD ["/opt/zookeeper/bin/config-and-run.sh"]
