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

ip=$(ifconfig | grep "inet " | grep -v 127.0.0.1|awk -F " " '{print $2}'|head -1)


# delete old master container and start new master container
sudo docker rm -f namenode &> /dev/null
echo "start namenode container..."
sudo docker run -d -t --dns 127.0.0.1 -p $ip:50070:50070 -p $ip:9000:9000 -p $ip:19888:19888 -p $ip:8088:8088 -p $ip:9995:8080 --name $clustername -e clustername=$clustername.tin.local -h $clustername.tin.local tinhuynh/hadoop-namenode &> /dev/null

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

echo "Start Hue"

#######################################
sudo mkdir -p /Users/hue/conf.d
sudo cp ./hue/conf/* /Users/hue/conf.d/
sudo sed -i "" "s/docker_host/"$ip"/g" /Users/hue/conf.d/hue.ini
sudo docker run -d -t --dns 127.0.0.1 -p 9998:8888 --name hue -e JOIN_IP=$FIRST_IP -v /Users/hue/conf.d:/hue/desktop/conf tinhuynh/hue
######################################

echo "Zeppeline Notebook address: $ip:9995"
echo "Hue address: $ip:9998"
