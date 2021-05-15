echo "start hadoop-master container"
echo "-----------------------------"
# docker rm -f hadoop-master &> /dev/null
docker run -itd --restart=always --net docker-bigdata-net --ip 172.21.0.22 --privileged -p 18032:8032 -p 28080:18080 -p 29888:19888 -p 17077:7077 -p 51070:50070 -p 18888:8888 -p 19000:9000 -p 11100:11000 -p 51030:50030 -p 18050:8050 -p 18081:8081 -p 18900:8900 -p 18088:8088 -p 17010:16010 --name hadoop-master --hostname hadoop-master  --add-host hadoop-slave1:172.21.0.23 --add-host hadoop-slave2:172.21.0.24 liuyang0001/docker-bigdata /usr/sbin/init
echo ""
echo "start hadoop-slave1 container"
echo "-----------------------------"

docker run -itd --restart=always --net docker-bigdata-net --ip 172.21.0.23 --privileged -p 18042:8042 -p 51010:50010 -p 51020:50020 --name hadoop-slave1 --hostname hadoop-slave1  --add-host hadoop-master:172.21.0.22 --add-host hadoop-slave2:172.21.0.24 liuyang0001/docker-bigdata /usr/sbin/init

echo "start hadoop-slave2 container"
echo "-----------------------------"
docker run -itd --restart=always --net docker-bigdata-net --ip 172.21.0.24 --privileged -p 18043:8042 -p 51011:50011 -p 51021:50021 --name hadoop-slave2 --hostname hadoop-slave2 --add-host hadoop-master:172.21.0.22 --add-host hadoop-slave1:172.21.0.23 liuyang0001/docker-bigdata /usr/sbin/init
echo ""
echo "启动 sshd"
echo "---------"
docker exec -it hadoop-master /etc/init.d/ssh start
docker exec -it hadoop-slave1 /etc/init.d/ssh start
docker exec -it hadoop-slave2 /etc/init.d/ssh start
echo ""
echo "初始化中"
echo "-------"
docker exec -it hadoop-master sh init_all.sh

echo "_______________________________________________________"
echo "HDFS File        http://localhost:51070/explorer.html#/"
echo "NameNode Info    http://localhost:51070/"
echo "Hadoop App       http://localhost:18088/"
echo "Spark App        http://localhost:18888/"
echo "________________________________________"
echo ""
echo "finished."
echo "---------"