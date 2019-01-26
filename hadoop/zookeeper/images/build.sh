#!/bin/sh

# $1: 镜像标签                 
# $2: 是否推送到镜像仓库       

set -e
                                 
if [ -n "$1" ]; then           
   TAG=$1
fi

REGISTRY=${REGISTRY:-"hub.cloudx5.com/"}
TAG=${TAG:-"1.0.0"}
IMAGE=${IMAGE:-"justep/hbase-zookeeper:${TAG}"}

docker build --rm=true --tag=${REGISTRY}${IMAGE} .
if [ "$2"x = "true"x ]; then
   docker push ${REGISTRY}${IMAGE} 
fi

