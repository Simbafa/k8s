#
# !!!!!!The file is a replica of spark-2.4.0-bin-hadoop2.7/kubernetes/dockerfiles/spark/Dockerfile
#

FROM openjdk:8-alpine

# Before building the docker image, first build and make a Spark distribution following
# the instructions in http://spark.apache.org/docs/latest/building-spark.html.
# If this docker file is being used in the context of building your images from a Spark
# distribution, the docker build command should be invoked from the top level directory
# of the Spark distribution. E.g.:
# docker build -t spark:latest -f kubernetes/dockerfiles/spark/Dockerfile .

RUN set -ex && \
    apk upgrade --no-cache && \
    apk add --no-cache bash tini libc6-compat linux-pam && \
    mkdir -p /opt/spark && \
    mkdir -p /opt/spark/work-dir && \
    touch /opt/spark/RELEASE && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd

COPY conf /opt/spark/conf
COPY jars /opt/spark/jars
COPY bin /opt/spark/bin
COPY sbin /opt/spark/sbin
COPY examples /opt/spark/examples
COPY data /opt/spark/data
ADD log4j.properties /opt/spark/conf/log4j.properties
ADD start-common.sh start-worker start-master /

ENV SPARK_HOME /opt/spark
ENV PATH $PATH:/opt/spark/bin

WORKDIR /opt/spark/work-dir

