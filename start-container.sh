#!/bin/bash

# run N slave containers
N=$1

# the defaut node number is 3
if [ $# = 0 ]
then
	N=3
fi


# delete old master container and start new master container
sudo docker rm -f namenode &> /dev/null
echo "start namenode container..."
sudo docker run -d -t --dns 127.0.0.1 -P --name namenode -h namenode.tin.local -w /root tinhuynh/hadoop-namenode &> /dev/null

# get the IP address of master container
FIRST_IP=$(sudo docker inspect --format="{{.NetworkSettings.IPAddress}}" namenode)

# delete old slave containers and start new slave containers
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f datanode$i &> /dev/null
	echo "start datanode$i container..."
	sudo docker run -d -t --dns 127.0.0.1 -P --name datanode$i -h datanode$i.tin.local -e JOIN_IP=$FIRST_IP tinhuynh/hadoop-datanode &> /dev/null
	i=$(( $i + 1 ))
done
