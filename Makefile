init:
	docker network create --subnet=172.21.0.0/24  docker-bigdata-net
	sh build.sh

build:
	sh build.sh

up:
	sh /home/liu/docker-bigdata/config/start_containers.sh

down:
	sh /home/liu/docker-bigdata/config/stop_containers.sh

bash01:
	docker exec -it hadoop-master bash

bash02:
	docker exec -it hadoop-slave1 bash

bash03:
	docker exec -it hadoop-slave2 bash

network:
	docker network create --subnet=172.21.0.0/24  docker-bigdata-net

# save:
# 	docker tag liuyang0001/docker-bigdata:

ps:
	docker ps

images:
	docker images

