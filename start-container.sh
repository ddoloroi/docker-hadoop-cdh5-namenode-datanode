#!/bin/bash

# run N slave containers
N=$1
clustername=$2

# the defaut node number is 3
if [[ ( $1 = 0 ) || ( $2 = 0 ) || ( $# = 0 ) ]]
then
	echo "Please input cluster name."
	echo "Example: ./start-container.sh 1 master"
else

ip=$(hostname -I|awk '{print $1}')


# delete old master container and start new master container
sudo docker rm -f namenode &> /dev/null
echo "start namenode container..."
sudo docker run -d -t --dns 127.0.0.1 -p $ip:50070:50070 -p $ip:8088:8088 --name $clustername -e clustername=$clustername.tin.local -h $clustername.tin.local tinhuynh/hadoop-namenode &> /dev/null

# get the IP address of master container
FIRST_IP=$(sudo docker inspect --format="{{.NetworkSettings.IPAddress}}" $clustername)

# delete old slave containers and start new slave containers
i=1
while [ $i -le $N ]
do
	sudo docker rm -f datanode$i &> /dev/null
	echo "start datanode$i container..."
	sudo docker run -d -t --dns 127.0.0.1 -P --name datanode$i -h datanode$i.tin.local -e JOIN_IP=$FIRST_IP -e clustername=$clustername.tin.local tinhuynh/hadoop-datanode &> /dev/null
	i=$(( $i + 1 ))
done

echo "Your cluste name is: $clustername.tin.local"
fi
