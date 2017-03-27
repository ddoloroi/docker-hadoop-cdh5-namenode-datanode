export JAVA_HOME=/usr/share/jdk
export MASTER=yarn-client

export SPARK_HOME=/usr/share/spark                             # (required) When it is defined, load it instead of Zeppelin embedded Spark libraries
# export SPARK_SUBMIT_OPTIONS                   # (optional) extra options to pass to spark submit. eg) "--driver-memory 512M --executor-memory 1G".
export SPARK_APP_NAME=zeppelin                         # (optional) The name of spark application.

export HADOOP_CONF_DIR=/etc/hadoop/conf