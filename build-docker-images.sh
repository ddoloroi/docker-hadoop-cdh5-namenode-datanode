#!/bin/bash

image=$1

if [ $# = 0 ]
then
	echo "Please use image name as the argument! "
	echo "The images name should be: hadoop-namenode and hadoop-datanode"
	exit 1
fi


# founction for delete images
function docker_rmi()
{
	echo -e "\n\nsudo docker rmi tinhuynh/$image"
	sudo docker rmi tinhuynh/$image
}


# founction for build images
function docker_build()
{
	cd $image
	echo -e "\n\nsudo docker build -t tinhuynh/$image ."
	sudo docker build -t tinhuynh/$image .
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
elif [ $image == "hue" ]
then
	docker_rmi hue
	docker_build hue
elif [ $1 == "all" ]
then
	cd hadoop-namenode
	docker_rmi hadoop-namenode
	echo -e "\n\nsudo docker build -t tinhuynh/hadoop-namenode ."
	sudo docker build -t tinhuynh/hadoop-namenode .
	cd ..
	cd hadoop-datanode
	docker_rmi hadoop-datanode
	echo -e "\n\nsudo docker build -t tinhuynh/hadoop-datanode ."
	sudo docker build -t tinhuynh/hadoop-datanode .
	cd ..
	cd hue
	docker_rmi hue
	echo -e "\n\nsudo docker build -t tinhuynh/hue ."
	sudo docker build -t tinhuynh/hue .
	cd ..
else
	echo "The image name is wrong!"
	echo "The images name should be: hadoop-namenode and hadoop-datanode"
fi

echo -e "\nimages after build"
sudo docker images
