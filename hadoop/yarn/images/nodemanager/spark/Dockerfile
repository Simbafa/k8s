
# docker build -t hub.cloudx5.com/justep/yarn-nm-spark:1.0.0 .

FROM hub.cloudx5.com/justep/yarn-nm:1.0.0

RUN curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/spark-1.6.3-bin-hadoop2.4-without-hive.tgz | tar -xzf - -C /usr/local \
    && mv /usr/local/spark-1.6.3-bin-hadoop2.4-without-hive /usr/local/spark

ADD spark-env.sh /usr/local/spark/conf/spark-env.sh

ADD bootstrap.sh /config/bootstrap.sh
RUN chmod a+x /config/bootstrap.sh
ENTRYPOINT /config/bootstrap.sh

