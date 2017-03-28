# Creates hadoop namenode image with serf and dnsmasq
FROM centos:6.8

MAINTAINER Tin Huynh <vantintttp@gmail.com>

#add jdk to images
RUN yum install -y wget
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz" -P /tmp/
RUN cd /tmp/ && tar -zxvf jdk-8u121-linux-x64.tar.gz
RUN mv /tmp/jdk1.8.0_121 /usr/share/jdk

#set java environment
ENV JAVA_HOME /usr/share/jdk
ENV PATH $JAVA_HOME/bin:$PATH
ENV clustername ${clustername}


#Install CDH repo
RUN curl -Lso cloudera-cdh-5-0.x86_64.rpm https://archive.cloudera.com/cdh5/one-click-install/redhat/6/x86_64/cloudera-cdh-5-0.x86_64.rpm
RUN rpm -Uvh cloudera-cdh-5-0.x86_64.rpm

#Install numpy
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN yum install -y numpy

#Install hadoop namenode
RUN yum install -y hadoop-yarn-resourcemanager hadoop-hdfs-namenode hadoop-mapreduce-historyserver
RUN yum install -y unzip
RUN yum install -y dnsmasq

#Add hdfs users to sudoers file
RUN echo "hdfs    ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

#Create log of hadoop namenode
RUN mkdir -p /var/lib/hadoop-hdfs/yarn/local && \
mkdir -p /var/lib/hadoop-hdfs/yarn/local/logs && \
mkdir -p /var/log/hadoop-yarn/apps

#Set permission of log folder
RUN chown -R yarn:yarn /var/lib/hadoop-hdfs/yarn/local /var/lib/hadoop-hdfs/yarn/local/logs /var/log/hadoop-yarn/apps

# Format namanode folder
RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/name
RUN hadoop namenode -format -force
RUN chown hdfs:hdfs -R /var/lib/hadoop-hdfs/cache/hdfs/


# dnsmasq configuration
ADD dnsmasq/* /etc/
ADD files/* /etc/hadoop/conf/
ADD scripts /etc/scripts

# install serf
RUN curl -Lso serf.zip https://releases.hashicorp.com/serf/0.7.0/serf_0.7.0_linux_amd64.zip && \
unzip serf.zip -d /bin && \
rm serf.zip

# configure serf
ENV SERF_CONFIG_DIR /etc/serf
ADD serf/* $SERF_CONFIG_DIR/
ADD handlers $SERF_CONFIG_DIR/handlers

# Get spark
RUN useradd spark
RUN su - spark
RUN curl -Lso spark.tgz http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.6.tgz
RUN tar -zxvf spark.tgz
RUN mv spark-* /usr/share/spark
ADD files/spark-env.sh /usr/share/spark/conf/ 

ENV SPARK_HOME /usr/share/spark
ENV PATH $SPARK_HOME/bin:$PATH

# Get zeppelin
RUN curl -lso zeppelin.tgz http://mirrors.viethosting.com/apache/zeppelin/zeppelin-0.7.0/zeppelin-0.7.0-bin-all.tgz
RUN tar -zxvf zeppelin.tgz
RUN mv zeppelin-* /usr/share/zeppelin
ADD files/zeppelin-env.sh /usr/share/zeppelin/conf/
ADD files/start-zeppelin.sh /var/lib/hadoop-hdfs/
RUN chown -R hdfs:hdfs /usr/share/zeppelin
RUN chmod 755 /var/lib/hadoop-hdfs/start-zeppelin.sh
RUN chown -R hdfs:hdfs /var/lib/hadoop-hdfs/start-zeppelin.sh

RUN chmod +x  $SERF_CONFIG_DIR/event-router.sh $SERF_CONFIG_DIR/start-serf-agent.sh /etc/scripts/* /etc/serf/start-ssh-serf.sh $SERF_CONFIG_DIR/handlers/*

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060 8080

CMD '/etc/scripts/hadoop-namenode.sh'; 'bash'
