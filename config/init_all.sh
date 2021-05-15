#!/bin/bash
# hadoop初始化
hdfs namenode -format

# 关闭host严格模式
ssh root@hadoop-master "echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config"

# zk集群配置
ssh root@hadoop-master "echo '0' > $ZK_HOME/datadir/myid"
ssh root@hadoop-slave1 "echo '1' > $ZK_HOME/datadir/myid"
ssh root@hadoop-slave2 "echo '2' > $ZK_HOME/datadir/myid"

# kafka集群
# 将某个文件中的"broker.id=0"字符串替换为"broker.id=x",master这句可删除
ssh root@hadoop-master "sed -i 's/broker.id=0/broker.id=0/g' $KAFKA_HOME/config/server.properties"
ssh root@hadoop-slave1 "sed -i 's/broker.id=0/broker.id=1/g' $KAFKA_HOME/config/server.properties"
ssh root@hadoop-slave2 "sed -i 's/broker.id=0/broker.id=2/g' $KAFKA_HOME/config/server.properties"

echo ""
echo "finished."
echo "---------"