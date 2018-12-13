
# docker build -t hub.cloudx5.com/justep/yarn-rm:1.0.0 .

FROM hub.cloudx5.com/justep/hadoop-base:1.0.0
RUN mkdir -p /config
RUN mkdir -p /data

# config hadoop
ADD hadoop-env.sh /etc/hadoop/hadoop-env.sh
ADD core-site.xml.template /etc/hadoop/core-site.xml.template
ADD hdfs-site.xml /etc/hadoop/hdfs-site.xml
ADD mapred-site.xml /etc/hadoop/mapred-site.xml
ADD yarn-site.xml /etc/hadoop/yarn-site.xml
ADD yarn.keytab /etc/hadoop/yarn.keytab
ADD container-executor.cfg /etc/hadoop/container-executor.cfg

ADD bootstrap.sh /config/bootstrap.sh
RUN chmod a+x /config/bootstrap.sh
RUN chmod 6050 /bin/container-executor
ENTRYPOINT /config/bootstrap.sh 

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122
