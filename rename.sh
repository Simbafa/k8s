#!/bin/bash

ORG=$1
REP=$2
for file in `find . -name "*.xml" -o -name "*.xml.*"  -o -name "*.yaml" -o -name "*.conf*"`
do
    sed -i "s/$ORG/$REP/g" $file
done

