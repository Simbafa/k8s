#!/bin/bash

error_exit() {
    echo "ERROR DURING CREATE CONFIG_MAP"
    exit 1
}

NAMESPACE='gitlab'
CM_NAME='gitlab-rb'
CM_FILE='gitlab.rb'

kubectl apply -f gitlab-ns.yaml
kubectl create configmap ${CM_NAME} --from-file=${CM_FILE} -n $NAMESPACE || error_exit
kubectl apply -f gitlab.yaml
