#!/bin/bash
echo "--------------------------"
$HADOOP_HOME/sbin/start-dfs.sh

echo "--------------------------"
$HADOOP_HOME/sbin/start-yarn.sh

echo "--------------------------"
$SPARK_HOME/sbin/start-all.sh

echo "--------------------------"
hdfs dfs -mkdir /mr-history
hdfs dfs -mkdir /stage

echo "--------------------------"
#修改需要配置及启动zk命令的命令
ssh root@hadoop-master "source /etc/profile;/usr/local/zookeeper-3.4.10/bin/zkServer.sh start"
ssh root@hadoop-slave1 "source /etc/profile;/usr/local/zookeeper-3.4.10/bin/zkServer.sh start"
ssh root@hadoop-slave2 "source /etc/profile;/usr/local/zookeeper-3.4.10/bin/zkServer.sh start"
echo "--------------------------"


echo "_______________________________________________________"
echo "HDFS File        http://localhost:51070/explorer.html#/"
echo "NameNode Info    http://localhost:51070/"
echo "Hadoop App       http://localhost:18088/"
echo "Spark App        http://localhost:18888/"
echo "________________________________________"
echo ""
echo "finished."
echo "---------"