#!/bin/bash

clustername=$1
datanode_add=$2
docpro=$(docker ps -a|grep $clustername)

if [[ ( $1 = 0 ) || ( $2 = 0 ) || ( $# = 0 ) ]]
then
	echo "Please input clustername and datanode"
	echo "Example: ./add_datanode.sh cluster 2"
elif [ -n "$docpro" ]
then
	current_datanode=$(docker ps --filter="name=datanode" -q|wc -l)
	echo "$clustername existed"
	FIRST_IP=$(sudo docker inspect --format="{{.NetworkSettings.IPAddress}}" $clustername)
	i=$(( $current_datanode + 1 ))
	N=$(( $current_datanode + $datanode_add ))
	while [ $i -le $N ]
	do
		sudo docker run -d -t --dns 127.0.0.1 -P --name datanode$i -h datanode$i.tin.local -e JOIN_IP=$FIRST_IP -e clustername=$clustername.tin.local tinhuynh/hadoop-datanode &> /dev/null
		i=$(( $i + 1 ))
	done
else
	echo "$clustername doen't existed"
fi
