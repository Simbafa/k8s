# docker build -t hub.cloudx5.com/justep/ldap:1.0.0 .

FROM ubuntu:18.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install slapd ldap-utils ldapscripts vim && \
    mkdir -p /etc/ldap/slapd.d /ldap.d && \
    rm -rf /var/lib/apt/lists/*

RUN mv /etc/ldap/slapd.d /etc/ldap/slapd.d.cache

EXPOSE 389

COPY config_ldap.sh entrypoint.sh schema_convert.conf /
COPY kerberos.schema /etc/ldap/schema/
COPY slapd.conf /

RUN chmod +x /config_ldap.sh
RUN /config_ldap.sh

ENTRYPOINT ["/entrypoint.sh"]
