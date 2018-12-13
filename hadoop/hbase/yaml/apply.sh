#/bin/sh

kubectl apply -f hbase_pod_master.yaml

kubectl apply -f hbase_pod_region.yaml
