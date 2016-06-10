# Creates a base ubuntu image with serf and dnsmasq
FROM centos:6.6

MAINTAINER Tin Huynh <vantintttp@gmail.com>

ADD software/jdk-8u91-linux-x64.tar.gz /tmp/
RUN mv /tmp/jdk1.8.0_91 /usr/share/

#set java environment
ENV JAVA_HOME /usr/share/jdk1.8.0_91
ENV PATH $JAVA_HOME/bin:$PATH
ENV clustername ${clustername}


RUN curl -Lso cloudera-cdh-5-0.x86_64.rpm https://archive.cloudera.com/cdh5/one-click-install/redhat/6/x86_64/cloudera-cdh-5-0.x86_64.rpm
RUN rpm -Uvh cloudera-cdh-5-0.x86_64.rpm


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
