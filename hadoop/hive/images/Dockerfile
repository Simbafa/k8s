
# docker build -t hub.cloudx5.com/justep/hive:1.0.0 .

FROM hub.cloudx5.com/justep/yarn-nm-spark:1.0.0

RUN curl -L --user x5:x5 ftp://192.168.0.254:6021/docker-bin-files/hadoop/apache-hive-2.1.1-bin.tar.gz | tar -xzf - -C /
RUN mv /apache-hive-2.1.1-bin /usr/local/hive
WORKDIR /usr/local/hive

RUN cp /usr/local/spark/lib/spark* /usr/local/hive/lib

ENV HIVE_HOME=/usr/local/hive
ENV HIVE_CONF_DIR=/usr/local/hive/conf

ADD mysql-connector-java-5.1.47-bin.jar /usr/local/hive/lib/
ADD HiveAdmin-1.0.0.jar /usr/local/hive/lib/
ADD hive-site.xml /usr/local/hive/conf/hive-site.xml
ADD hive-env.sh /usr/local/hive/conf/hive-env.sh
ADD hive.keytab /usr/local/hive/conf/hive.keytab
ADD localhost.keytab /usr/local/hive/conf/localhost.keytab

ADD core-site.xml.template /etc/hadoop/core-site.xml.template

ADD bootstrap.sh /config/bootstrap.sh
RUN chmod a+x /config/bootstrap.sh
ENTRYPOINT /config/bootstrap.sh 

# Hive MetaStore
EXPOSE 9083
# Hive WebUI
EXPOSE 10002
# Hive Master
EXPOSE 10000
