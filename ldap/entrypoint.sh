#!/usr/bin/env bash

FROMHOST=/var/lib/ldap

if [ ! -f $FROMHOST/ldap_initialized ]; then
  touch $FROMHOST/ldap_initialized
  cp /etc/ldap/slapd.d $FROMHOST/ -fr
  cp /etc/ldap/ldap.conf $FROMHOST/ldap.conf

fi

cp /slapd.conf /etc/ldap/sasl2/
cp $FROMHOST/ldap.conf /etc/ldap/ldap.conf

nohup slapd -h 'ldap:/// ldapi:///' -F $FROMHOST/slapd.d -d stats >/dev/null 2>$FROMHOST/error.log &

STARTED=0
while [ $STARTED -eq 0 ]; do
    RET=`cat $FROMHOST/error.log | grep "slapd starting" | wc -l`
    if [ $RET -eq 0 ]; then 
        sleep 1s
    else
        STARTED=1
    fi
done

echo "Ldap started!"

FILE=$FROMHOST/kerberos.ldif
if [ ! -f $FILE ]; then
    Result=`slapcat -f /schema_convert.conf -F /tmp -n0 | grep kerberos,cn=schema`
    DN="`echo $Result | sed 's/dn: //g'`"
    Result=`slapcat -f /schema_convert.conf -F /tmp -n0 -H ldap:///$DN -l $FILE`
    cat $FILE
    N=$(sed -n '$=' $FILE)
    sed -i $(($N-7)),${N}d $FILE
    sed -i 's|{.*}kerberos|kerberos|g' $FILE
    cat $FILE
    ldapadd -Q -Y EXTERNAL -H ldapi:/// -f $FILE
fi

tail -f $FROMHOST/error.log

