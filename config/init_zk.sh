#!/bin/bash
ssh root@hadoop-master "echo '0' >> $ZK_HOME/datadir/myid"
ssh root@hadoop-slave1 "echo '1' >> $ZK_HOME/datadir/myid"
ssh root@hadoop-slave2 "echo '2' >> $ZK_HOME/datadir/myid"

#修改需要配置及启动zk命令的命令
ssh root@hadoop-master "source /etc/profile;/usr/local/zookeeper-3.4.10/bin/zkServer.sh start"
ssh root@hadoop-slave1 "source /etc/profile;/usr/local/zookeeper-3.4.10/bin/zkServer.sh start"
ssh root@hadoop-slave2 "source /etc/profile;/usr/local/zookeeper-3.4.10/bin/zkServer.sh start"


