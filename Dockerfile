FROM ubuntu
MAINTAINER liuyang0001 liuyang0001@outlook.com

ENV BUILD_ON 2021-5-9

RUN apt-get update -qqy

RUN apt-get -qqy install vim wget net-tools  iputils-ping  openssh-server
#添加JDK
ADD ./jdk-8u161-linux-x64.tar.gz /usr/local/
#添加hadoop
ADD ./hadoop-2.7.5.tar.gz  /usr/local/
#添加scala
ADD ./scala-2.11.8.tgz /usr/local/
#添加spark
ADD ./spark-2.2.0-bin-hadoop2.7.tgz /usr/local/
#添加zookeeper
ADD ./zookeeper-3.4.10.tar.gz /usr/local/
#添加HBase
ADD ./hbase-1.2.6-bin.tar.gz /usr/local/
#添加Hive
ADD ./apache-hive-2.3.3-bin.tar.gz /usr/local/
#添加Flume
ADD ./apache-flume-1.8.0-bin.tar.gz /usr/local/
#添加Kafka
ADD ./kafka_2.11-1.0.0.tgz /usr/local/

ENV CHECKPOINT 2021-5-9
#增加JAVA_HOME环境变量
ENV JAVA_HOME /usr/local/jdk1.8.0_161
#hadoop环境变量
ENV HADOOP_HOME /usr/local/hadoop-2.7.5
#scala环境变量
ENV SCALA_HOME /usr/local/scala-2.11.8
#spark环境变量
ENV SPARK_HOME /usr/local/spark-2.2.0-bin-hadoop2.7
#zk环境变量
ENV ZK_HOME /usr/local/zookeeper-3.4.10
#HBase环境变量
ENV HBASE_HOME /usr/local/hbase-1.2.6
#Hive环境变量
ENV HIVE_HOME /usr/local/apache-hive-2.3.3-bin
#Flume环境变量
ENV FLUME_HOME /usr/local/apache-flume-1.8.0-bin
#Kafka环境变量
ENV KAFKA_HOME /usr/local/kafka_2.11-1.0.0
#将环境变量添加到系统变量中
ENV PATH $KAFKA_HOME/bin:$FLUME_HOME/bin:$HIVE_HOME/bin:$HBASE_HOME/bin:$ZK_HOME/bin:$SCALA_HOME/bin:$SPARK_HOME/bin:$HADOOP_HOME/bin:$JAVA_HOME/bin:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$PATH

RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 600 ~/.ssh/authorized_keys
#复制配置文件到/tmp目录
COPY config /tmp
#将配置移动到正确的位置
RUN mv /tmp/ssh_config    ~/.ssh/config && \
    mv /tmp/profile /etc/profile && \
    mv /tmp/masters $SPARK_HOME/conf/masters && \
    cp /tmp/slaves $SPARK_HOME/conf/ && \
    mv /tmp/spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf && \
    mv /tmp/spark-env.sh $SPARK_HOME/conf/spark-env.sh && \ 
    mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/master $HADOOP_HOME/etc/hadoop/master && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    # mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    # mv /tmp/init_zk.sh ~/init_zk.sh && \
    mkdir -p /usr/local/hadoop2.7/dfs/data && \
    mkdir -p /usr/local/hadoop2.7/dfs/name && \
    mkdir -p /usr/local/zookeeper-3.4.10/datadir && \
    mkdir -p /usr/local/zookeeper-3.4.10/log && \
    mv /tmp/zoo.cfg $ZK_HOME/conf/zoo.cfg && \
    mv /tmp/hbase-env.sh $HBASE_HOME/conf/hbase-env.sh && \
    mv /tmp/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml  && \
    mv /tmp/regionservers $HBASE_HOME/conf/regionservers && \
    mv /tmp/hive-env.sh $HIVE_HOME/conf/hive-env.sh && \
    mv /tmp/flume-env.sh $FLUME_HOME/conf/flume-env.sh && \
    mv /tmp/server.properties $KAFKA_HOME/config/server.properties && \
    # mv /tmp/init_kafka.sh ~/init_kafka.sh && \
    # 添加mysql-jdbc驱动
    mv /tmp/mysql-connector-java-5.1.28.jar  /usr/local/spark-2.2.0-bin-hadoop2.7/jars/mysql-connector-java-5.1.28.jar &&\
    mv /tmp/init_all.sh ~/init_all.sh && \
    mv /tmp/start_all.sh ~/start_all.sh && \
    mv /tmp/stop_all.sh ~/stop_all.sh

RUN echo $JAVA_HOME
#设置工作目录
WORKDIR /root
#启动sshd服务
RUN /etc/init.d/ssh start
#修改start-hadoop.sh权限为700
# RUN chmod 700 start-hadoop.sh
#修改start_all.sh权限为700
RUN chmod 700 start_all.sh
#修改stop_all.sh权限为700
RUN chmod 700 stop_all.sh
#修改init_zk.sh权限为700
# RUN chmod 700 init_zk.sh
#修改init_kafka.sh权限为700
# RUN chmod 700 init_kafka.sh
#修改init_all.sh权限为700
RUN chmod 700 init_all.sh
#修改root密码
RUN echo "root:qwe" | chpasswd
CMD ["/bin/bash"]
