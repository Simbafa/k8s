#!/bin/bash

kubectl get sa default -n bigdata -o yaml |
sed  '/resourceVersion/d'|
sed  '/kind: ServiceAccount/a\imagePullSecrets:\n- name: hub.cloudx5.com' |
kubectl replace sa default -n bigdata -f -
