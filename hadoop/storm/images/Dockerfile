FROM java:8-jre

ENV STORM_VERSION 1.2.2

RUN apt-get update && apt-get install -y python vim

RUN curl -o /apache-storm.tar.gz http://www.apache.org/dist/storm/apache-storm-${STORM_VERSION}/apache-storm-${STORM_VERSION}.tar.gz && \
    tar -C /usr/local -xzf /apache-storm.tar.gz && \
    rm /apache-storm.tar.gz && \
    mv /usr/local/apache-storm-${STORM_VERSION} /usr/local/apache-storm && \
    rm /usr/local/apache-storm/conf/storm.yaml && \
    mkdir -p /usr/local/apache-storm/data && \
    mkdir -p /usr/local/apache-storm/logs

COPY run.sh storm.yaml /

WORKDIR /usr/local/apache-storm
ENV PATH $PATH:/usr/local/apache-storm/bin

# https://github.com/apache/storm/blob/master/SECURITY.md
EXPOSE 6700 6701 6702 6703 8080 6627

CMD ["/run.sh"]

