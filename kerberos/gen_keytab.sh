#!/bin/sh

#hdfs:
kadmin.local -q "addprinc -randkey root/namenode@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/datanode@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/journalnode@JUSTEP.COM"
kadmin.local -q "addprinc -randkey http/web@JUSTEP.COM"

#zookeeper:
kadmin.local -q "addprinc -randkey root/zookeeper@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zookeeper/10.96.100.11@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zookeeper/10.96.100.12@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zookeeper/10.96.100.13@JUSTEP.COM"

#hbase:
kadmin.local -q "addprinc -randkey root/hbase-master-1@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/hbase-region-1@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/hbase-region-2@JUSTEP.COM"
kadmin.local -q "addprinc -randkey zkcli@JUSTEP.COM"

kadmin.local -q "xst -k all.keytab -norandkey root/namenode@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey root/datanode@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey root/journalnode@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey http/web@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey root/zookeeper@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey zookeeper/10.96.100.11@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey zookeeper/10.96.100.12@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey zookeeper/10.96.100.13@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey root/hbase-master-1@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey root/hbase-region-1@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey root/hbase-region-2@JUSTEP.COM"
kadmin.local -q "xst -k all.keytab -norandkey zkcli@JUSTEP.COM"

#yarn:
kadmin.local -q "addprinc -randkey root/mapreduce@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/yarn-rm@JUSTEP.COM"
kadmin.local -q "addprinc -randkey root/yarn-nm@JUSTEP.COM"

kadmin.local -q "xst -k yarn.keytab -norandkey root/mapreduce@JUSTEP.COM"
kadmin.local -q "xst -k yarn.keytab -norandkey root/yarn-rm@JUSTEP.COM"
kadmin.local -q "xst -k yarn.keytab -norandkey root/yarn-nm@JUSTEP.COM"

#hive:
kadmin.local -q "addprinc -randkey hive@JUSTEP.COM"
kadmin.local -q "addprinc -randkey hive/hive@JUSTEP.COM"
kadmin.local -q "addprinc -randkey HTTP/localhost@JUSTEP.COM"
kadmin.local -q "xst -k hive.keytab -norandkey hive@JUSTEP.COM"
kadmin.local -q "xst -k hive.keytab -norandkey hive/hive@JUSTEP.COM"
kadmin.local -q "xst -k hive.keytab -norandkey HTTP/localhost@JUSTEP.COM"

