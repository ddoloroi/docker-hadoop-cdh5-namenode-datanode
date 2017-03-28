#!/bin/bash

#Update clustername
/etc/scripts/cluster_name.sh

#Start serf
/etc/serf/start-ssh-serf.sh

#Start join machine
/etc/serf/handlers/member-join > join_log &

#Start Hadoop
/etc/init.d/hadoop-hdfs-namenode start
/etc/init.d/hadoop-yarn-resourcemanager start
/etc/init.d/hadoop-mapreduce-historyserver start
su -c /var/lib/hadoop-hdfs/start-zeppelin.sh -s /bin/sh hdfs
su -c "hadoop dfs -mkdir /data" -s /bin/sh hdfs
