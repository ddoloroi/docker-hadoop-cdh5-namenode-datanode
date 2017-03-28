# Creates a base ubuntu image with serf and dnsmasq
FROM centos:6.8

MAINTAINER Tin Huynh <vantintttp@gmail.com>

#Install JDK
RUN yum install -y wget
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz" -P /tmp/
RUN cd /tmp/ && tar -zxvf jdk-8u121-linux-x64.tar.gz
RUN mv /tmp/jdk1.8.0_121 /usr/share/jdk

# Set java environment
ENV JAVA_HOME /usr/share/jdk
ENV PATH $JAVA_HOME/bin:$PATH
ENV clustername ${clustername}

# Install CDH repo
RUN curl -Lso cloudera-cdh-5-0.x86_64.rpm https://archive.cloudera.com/cdh5/one-click-install/redhat/6/x86_64/cloudera-cdh-5-0.x86_64.rpm
RUN rpm -Uvh cloudera-cdh-5-0.x86_64.rpm

# Install numpy
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN yum install -y numpy



RUN yum install -y hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce
RUN yum install -y unzip
RUN yum install -y dnsmasq

RUN echo "hdfs    ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /var/lib/hadoop-hdfs/yarn/local && \
mkdir -p /var/lib/hadoop-hdfs/yarn/local/logs && \
mkdir -p /var/log/hadoop-yarn/apps

RUN chown -R yarn:yarn /var/lib/hadoop-hdfs/yarn/local /var/lib/hadoop-hdfs/yarn/local/logs /var/log/hadoop-yarn/apps

# Create folder folder
RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/name && \
chown hdfs:hdfs -R /var/lib/hadoop-hdfs/cache/hdfs/


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


RUN chmod +x  $SERF_CONFIG_DIR/event-router.sh $SERF_CONFIG_DIR/start-serf-agent.sh /etc/scripts/* /etc/serf/start-ssh-serf.sh $SERF_CONFIG_DIR/handlers/*

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

CMD '/etc/scripts/hadoop-datanode.sh'; 'bash'
