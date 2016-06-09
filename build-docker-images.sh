#!/bin/bash

image=$1

if [ $# = 0 ]
then
	echo "Please use image name as the argument!"
	exit 1
fi


# founction for delete images
function docker_rmi()
{
	echo -e "\n\nsudo docker rmi tinhuynh/$1"
	sudo docker rmi tinhuynh/$1
}


# founction for build images
function docker_build()
{
	cd $1
	echo -e "\n\nsudo docker build -t tinhuynh/$1 ."
	/usr/bin/time -f "real  %e" sudo docker build -t tinhuynh/$1 .
	cd ..
}


if [ $image == "hadoop-namenode" ]
then
	docker_rmi hadoop-namenode
	docker_build hadoop-namenode
elif [ $image == "hadoop-datanode" ]
then
	docker_rmi hadoop-datanode
	docker_build hadoop-datanode
else
	echo "The image name is wrong!"
	echo "The images name should be: hadoop-namenode and hadoop-datanode"
fi

echo -e "\nimages after build"
sudo docker images
