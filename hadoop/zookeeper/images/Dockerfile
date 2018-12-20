# docker build -t hub.cloudx5.com/justep/hbase-zookeeper:1.0.0 .

FROM jboss/base-jdk:7

USER root

ENV ZOOKEEPER_VERSION 3.4.10
EXPOSE 2181 2888 3888

RUN yum -y install vim wget bind-utils krb5-workstation krb5-libs krb5-auth-dialog openldap openldap-clients nss-pam-ldapd pam_ldap cyrus-sasl-plain cyrus-sasl-devel  cyrus-sasl-gssapi cyrus-sasl-md5 && yum clean all \
    && wget -q -O - http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xzf - -C /opt \
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

COPY nsswitch.conf /etc/
COPY ldap.conf /etc/openldap/
COPY password-auth system-auth /etc/pam.d/
RUN chkconfig nslcd on

CMD ["/opt/zookeeper/bin/config-and-run.sh"]
