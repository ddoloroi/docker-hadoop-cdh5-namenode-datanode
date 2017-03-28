#!/bin/bash

for i in $(sudo docker ps -a|awk '{print $1}'); do sudo docker stop $i; sudo docker rm $i; done
