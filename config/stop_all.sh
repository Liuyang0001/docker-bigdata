#!/bin/bash
echo "--------------------------"
$HADOOP_HOME/sbin/stop-dfs.sh

echo "--------------------------"
$HADOOP_HOME/sbin/stop-yarn.sh

echo "--------------------------"
$SPARK_HOME/sbin/stop-all.sh

echo "--------------------------"
#关闭zk命令
ssh root@hadoop-master "/usr/local/zookeeper-3.4.10/bin/zkServer.sh stop"
ssh root@hadoop-slave1 "/usr/local/zookeeper-3.4.10/bin/zkServer.sh stop"
ssh root@hadoop-slave2 "/usr/local/zookeeper-3.4.10/bin/zkServer.sh stop"
echo "--------------------------"
echo ""
echo "finished."
echo "---------"