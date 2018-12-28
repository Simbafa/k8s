FROM hub.cloudx5.com/justep/hive:1.0.0

ENV SQOOP_HOME=/usr/local/sqoop
ENV HADOOP_HOME=
ENV HADOOP_COMMON_HOME=$HADOOP_HOME/share/hadoop/common
ENV HADOOP_HDFS_HOME=$HADOOP_HOME/share/hadoop/hdfs
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME/share/hadoop/mapreduce
ENV HADOOP_YARN_HOME=$HADOOP_HOME/share/hadoop/yarn
ENV PATH $SQOOP_HOME/bin:$PATH

ADD sqoop-1.99.7-bin-hadoop200.tar.gz /
RUN mv /sqoop-1.99.7-bin-hadoop200 $SQOOP_HOME
RUN cp /usr/local/hive/lib/mysql-connector-java-5.1.47-bin.jar $SQOOP_HOME/server/lib
ADD entrypoint.sh $SQOOP_HOME/
ADD sqoop.properties localhost.keytab $SQOOP_HOME/conf/

WORKDIR $SQOOP_HOME

EXPOSE 12000 9000

ENTRYPOINT "./entrypoint.sh"
