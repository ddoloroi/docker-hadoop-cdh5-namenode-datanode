#!/bin/bash

sed -i "s/ClusterName/"$clustername"/g" /etc/hadoop/conf/core-site.xml
sed -i "s/ClusterName/"$clustername"/g" /etc/hadoop/conf/yarn-site.xml
