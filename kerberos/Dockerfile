# docker build -t hub.cloudx5.com/justep/kerberos-ldap:1.0.0 .
FROM centos:6.6

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum install -y krb5-server krb5-libs krb5-auth-dialog krb5-workstation krb5-server-ldap

EXPOSE 88 749

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
