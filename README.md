
0. Install Docker on your host
  - https://docs.docker.com/engine/installation/

1. Run script to build images:
  - ./build-docker-images.sh hadoop-namenode
  - ./build-docker-images.sh hadoop-datanode

2. Run start container
  - ./start-container.sh number_of_datanode cluster_name
  - EX: ./start-container.sh 2 master

3. Add datanode to hadoop cluster has existed
  - ./add_more_datanode.sh cluster_name number_of_datanode
  - EX: ./add_more_datanode.sh master 2

4. Access to cluster
  - http://docker_host:50070
  - http://docker_host:8088

5. Access to zeppelin
  - http://docker_host:9995
