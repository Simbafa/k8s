
# docker build -t hub.cloudx5.com/justep/yarn-nm-spark:1.0.0 .

FROM hub.cloudx5.com/justep/yarn-nm:1.0.0

#ADD spark-2.4.0-bin-hadoop2.7.tgz /
#RUN mv /spark-2.4.0-bin-hadoop2.7 /usr/local/spark
ADD spark-1.6.3-bin-hadoop2.4-without-hive.tgz /
RUN mv /spark-1.6.3-bin-hadoop2.4-without-hive /usr/local/spark

ADD spark-env.sh /usr/local/spark/conf/spark-env.sh

ADD bootstrap.sh /config/bootstrap.sh
RUN chmod a+x /config/bootstrap.sh
ENTRYPOINT /config/bootstrap.sh

