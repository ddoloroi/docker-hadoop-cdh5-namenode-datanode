#!/bin/bash

#Start serf
/etc/serf/start-ssh-serf.sh

#Join node to cluster
/etc/serf/handlers/member-join

/etc/init.d/hadoop-hdfs-datanode start
/etc/init.d/hadoop-yarn-nodemanager start
