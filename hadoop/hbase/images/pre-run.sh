#!/bin/bash

cp /hbase/fromhost/krb5.conf /etc/
kinit -kt /hbase/conf/hbase.keytab root/hbase-master-1@JUSTEP.COM
klist 

