#!/bin/bash

[[ "TRACE" ]] && set -x

: ${REALM:=JUSTEP.COM}
: ${DOMAIN_REALM:=justep.com}
: ${KERB_MASTER_DB_PSW:=justep}
: ${KERB_ADMIN_USER:=admin}
: ${KERB_ADMIN_PASS:=admin}
: ${SEARCH_DOMAINS:=krb.justep}
: ${LDAP_DC:=dc=justep,dc=com}
: ${LDAP_USER:=admin}
: ${LDAP_PASS:=admin}
: ${LDAP_URL:=ldap://ldap}

fix_nameserver() {
  cat>/etc/resolv.conf<<EOF
nameserver $NAMESERVER_IP
search $SEARCH_DOMAINS
EOF
}

fix_hostname() {
  sed -i "/^hosts:/ s/ *files dns/ dns files/" /etc/nsswitch.conf
}

create_config() {
  : ${KDC_ADDRESS:=$(hostname -f)}

  cat>/etc/krb5.conf<<EOF
[logging]
 default = FILE:/var/log/kerberos/krb5libs.log
 kdc = FILE:/var/log/kerberos/krb5kdc.log
 admin_server = FILE:/var/log/kerberos/kadmind.log

[libdefaults]
 default_realm = $REALM
 dns_lookup_realm = false
 dns_lookup_kdc = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true

[realms]
 $REALM = {
  kdc = 0.0.0.0
  admin_server = 0.0.0.0
  default_domain = $DOMAIN_REALM
  database_module = openldap_ldapconf
 }

[domain_realm]
 .$DOMAIN_REALM = $REALM
 $DOMAIN_REALM = $REALM

[dbdefaults]
  ldap_kerberos_container_dn = cn=krbContainer,$LDAP_DC

[dbmodules]
  openldap_ldapconf = {
          db_library = kldap
          ldap_kdc_dn = "cn=$LDAP_USER,$LDAP_DC"

          # this object needs to have read rights on
          # the realm container, principal container and realm sub-trees
          ldap_kadmind_dn = "cn=$LDAP_USER,$LDAP_DC"

          # this object needs to have read and write rights on
          # the realm container, principal container and realm sub-trees
          #ldap_service_password_file = /etc/krb5kdc/service.keyfile
          ldap_service_password_file = /var/kerberos/krb5kdc/service.keyfile
          ldap_servers = $LDAP_URL
          ldap_conns_per_server = 5
  }
EOF
}

create_db() {
  /usr/sbin/kdb5_util -P $KERB_MASTER_DB_PSW -r $REALM create -s
}

init_ldap() {
  /usr/sbin/kdb5_ldap_util -D cn=$LDAP_USER,$LDAP_DC create -subtrees $LDAP_DC -r $REALM -s -H $LDAP_URL <<EOF
$LDAP_PASS
$KERB_ADMIN_PASS
$KERB_ADMIN_PASS
EOF
  #/usr/sbin/kdb5_ldap_util -D cn=$LDAP_USER,$LDAP_DC stashsrvpw -f /etc/krb5kdc/service.keyfile cn=$LDAP_USER,$LDAP_DC <<EOF
  /usr/sbin/kdb5_ldap_util -D cn=$LDAP_USER.,$LDAP_DC stashsrvpw -f /var/kerberos/krb5kdc/service.keyfile cn=$LDAP_USER,$LDAP_DC <<EOF
$LDAP_PASS
$LDAP_PASS
$LDAP_PASS
EOF
}

start_kdc() {
  #  service krb5-kdc start
  #  service krb5-admin-server start
  /etc/rc.d/init.d/krb5kdc start
  /etc/rc.d/init.d/kadmin start

  chkconfig krb5kdc on
  chkconfig kadmin on
}

restart_kdc() {
  #  service krb5-kdc restart
  #  service krb5-admin-server restart
  /etc/rc.d/init.d/krb5kdc restart
  /etc/rc.d/init.d/kadmin restart
}

create_admin_user() {
  kadmin.local -q "addprinc -pw $KERB_ADMIN_PASS $KERB_ADMIN_USER/admin"
 # echo "*/admin@$REALM *" > /etc/krb5kdc/kadm5.acl
  echo "*/admin@$REALM *" > /var/kerberos/krb5kdc/kadm5.acl
}

main() {
   mkdir -p /var/log/kerberos
  fix_nameserver
  fix_hostname

  if [ ! -f /kerberos_initialized ]; then
    create_config
    init_ldap
    create_admin_user
    create_db
    start_kdc

    touch /kerberos_initialized

    while true; do sleep 1000; done
  else
    start_kdc
    tail -F /var/log/kerberos/krb5kdc.log
  fi
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
