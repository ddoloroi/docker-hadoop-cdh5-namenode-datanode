

# Hadoop(2.6) + Spark(2.1) + Zeppelin

- Manage hadoop cluster integrate with Spark and Zeppelin and Hue by Docker

# How to build and start cluster by Docker
1. Install Docker on your host
    >https://docs.docker.com/engine/installation/

2. Run script to build images:
    >./build-docker-images.sh hadoop-namenode
    >./build-docker-images.sh hadoop-datanode
    >./build-docker-images.sh hue


3. Run start container
    >./start-container.sh number_of_datanode cluster_name
    >EX: ./start-container.sh 2 master

4. Add datanode to hadoop cluster has existed
    >./add_more_datanode.sh cluster_name number_of_datanode
    >EX: ./add_more_datanode.sh master 2

5. Access to cluster
    >http://docker_host:50070
    >http://docker_host:8088

6. Access to zeppelin
    >http://docker_host:9995

7. Access to Hue
    >http://docker_host:9998
    >Account: hdfs/hdfs

8. To use zeppelin:
  - Access above url
  - Create a new interpreter: enter name of Interpreter, in "Interpreter group" choose spark
  - Remove ```zeppelin.spark.useHiveContext```
  - Save this interpreter
  - Create new Notebook and choose this interpreter
