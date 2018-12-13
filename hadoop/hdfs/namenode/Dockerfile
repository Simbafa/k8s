
# docker build -t hub.cloudx5.com/justep/hadoop-hdfs-namenode:1.0.0 .

FROM hub.cloudx5.com/justep/hadoop-base:1.0.0
RUN mkdir -p /config
RUN mkdir -p /data
RUN apt-get update && apt install -y --no-install-recommends net-tools iputils-ping iproute2

# config hadoop
ADD hadoop-env.sh /etc/hadoop/hadoop-env.sh
ADD core-site.xml.template /etc/hadoop/core-site.xml.template
ADD hdfs-site.xml /etc/hadoop/hdfs-site.xml

# supervisord
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start hadoop
ADD pre-start-hadoop.sh /config/pre-start-hadoop.sh
RUN chmod a+x /config/pre-start-hadoop.sh
ENTRYPOINT /config/pre-start-hadoop.sh && /usr/bin/supervisord

EXPOSE 50020 50090 50070 50010 50075 8031 8032 8033 8040 8042 49707 22 8088 8030

