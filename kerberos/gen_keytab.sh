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

kadmin.local -q "xst -k hdfs.keytab -norandkey root/namenode@JUSTEP.COM"
kadmin.local -q "xst -k hdfs.keytab -norandkey root/datanode@JUSTEP.COM"
kadmin.local -q "xst -k hdfs.keytab -norandkey root/journalnode@JUSTEP.COM"
kadmin.local -q "xst -k hdfs.keytab -norandkey http/web@JUSTEP.COM"
kadmin.local -q "xst -k hbase.keytab -norandkey root/hbase-master-1@JUSTEP.COM"
kadmin.local -q "xst -k hbase.keytab -norandkey root/hbase-region-1@JUSTEP.COM"
kadmin.local -q "xst -k hbase.keytab -norandkey root/hbase-region-2@JUSTEP.COM"
kadmin.local -q "xst -k hbase.keytab -norandkey zkcli@JUSTEP.COM"

#zookeeper
kadmin.local -q "xst -k zookeeper.keytab -norandkey zookeeper/10.96.100.11@JUSTEP.COM"
kadmin.local -q "xst -k zookeeper.keytab -norandkey zookeeper/10.96.100.12@JUSTEP.COM"
kadmin.local -q "xst -k zookeeper.keytab -norandkey zookeeper/10.96.100.13@JUSTEP.COM"

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

#localhost
kadmin.local -q "xst -k localhost.keytab -norandkey HTTP/localhost@JUSTEP.COM"
kadmin.local -q "xst -k webhdfs.keytab -norandkey HTTP/localhost@JUSTEP.COM"
#multi-tenancy
kadmin.local -q "addprinc -randkey root/bdclient@JUSTEP.COM"
kadmin.local -q "xst -k admin.keytab -norandkey root/bdclient@JUSTEP.COM"
kadmin.local -q "xst -k admin.keytab -norandkey admin/admin@JUSTEP.COM"
