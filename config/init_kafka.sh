#!/bin/bash
# 将某个文件中的"broker.id=0"字符串替换为"broker.id=x",master这句可删除
ssh root@hadoop-master "sed -i 's/broker.id=0/broker.id=0/g' $KAFKA_HOME/config/server.properties"
ssh root@hadoop-slave1 "sed -i 's/broker.id=0/broker.id=1/g' $KAFKA_HOME/config/server.properties"
ssh root@hadoop-slave2 "sed -i 's/broker.id=0/broker.id=2/g' $KAFKA_HOME/config/server.properties"
