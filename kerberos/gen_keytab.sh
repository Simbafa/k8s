#!/bin/sh

#hdfs:
kadmin.local -q "addprinc -randkey root/namenode@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/datanode@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/journalnode@JUSTEP.COM"
kadmin.local -q "addprinc -randkey http/web@JUSTEP.COM"

#zookeeper:
kadmin.local -q "addprinc -randkey root/zookeeper@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zookeeper/10.96.9.11@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zookeeper/10.96.9.12@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zookeeper/10.96.9.13@JUSTEP.COM"

#hbase:
kadmin.local -q "addprinc -randkey root/hbase-master-1@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/hbase-region-1@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/hbase-region-2@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zkcli@JUSTEP.COM"

kadmin.local -q "xst -k all.keytab root/namenode@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab root/datanode@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab root/journalnode@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab http/web@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab root/zookeeper@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab zookeeper/10.96.9.11@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab zookeeper/10.96.9.12@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab zookeeper/10.96.9.13@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab root/hbase-master-1@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab root/hbase-region-1@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab root/hbase-region-2@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab zkcli@JUSTEP.COM"

#yarn:
kadmin.local -q "addprinc -randkey root/mapreduce@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/yarn-rm@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/yarn-nm@JUSTEP.COM"

kadmin.local -q "xst -k yarn.keytab root/mapreduce@JUSTEP.COM"
kadmin.local -q "xst -k yarn.keytab root/yarn-rm@JUSTEP.COM"
kadmin.local -q "xst -k yarn.keytab root/yarn-nm@JUSTEP.COM"

#hive:
kadmin.local -q "addprinc -randkey hive@JUSTEP.COM"
kadmin.local -q "addprinc -randkey hive/hive@JUSTEP.COM"
kadmin.local -q "addprinc -randkey HTTP/localhost@JUSTEP.COM"
kadmin.local -q "xst -k hive.keytab hive@JUSTEP.COM"
kadmin.local -q "xst -k hive.keytab hive/hive@JUSTEP.COM"
kadmin.local -q "xst -k hive.keytab HTTP/localhost@JUSTEP.COM"

