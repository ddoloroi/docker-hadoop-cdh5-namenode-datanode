# Alternate conf dir. (Default: ${SPARK_HOME}/conf)
export SPARK_CONF_DIR=/home/spark/spark

# Where log files are stored.(Default:${SPARK_HOME}/logs)
#export SPARK_LOG_DIR=${SPARK_HOME:-/usr/hdp/current/spark-client}/logs
export SPARK_LOG_DIR=/var/log/spark

# Where the pid file is stored. (Default: /tmp)
export SPARK_PID_DIR=/var/run/spark

#export HADOOP_HOME=/usr/lib/hadoop
export HADOOP_CONF_DIR=/etc/hadoop/conf

# The java implementation to use.
export JAVA_HOME=/usr/share/jdk
