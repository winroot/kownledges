# 1.kafka 创建topic命令
## 启动zookeeper:
bin/zookeeper-server-start.sh config/zookeeper.properties &

## 启动kafka:
bin/kafka-server-start.sh config/server.properties &

## 创建topic:
./kafka-topics.sh --create --zookeeper 192.168.1.32:2181 --replication-factor 1 --partitions 4 --topic test_diy_partition

## 查看topic:
bin/kafka-topics.sh --list --zookeeper localhost:2181
