#!/bin/bash

$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh


$SPARK_HOME/sbin/start-all.sh


hdfs dfs -mkdir /mr-history
hdfs dfs -mkdir /stage

echo "finished."
echo "---------"