echo "stop containers" 
echo "---------------"

docker stop hadoop-master
docker stop hadoop-slave1
docker stop hadoop-slave2

echo ""
echo "rm containers"
echo "-------------"

docker rm hadoop-master
docker rm hadoop-slave1
docker rm hadoop-slave2

echo ""
echo "finished."
echo "---------"