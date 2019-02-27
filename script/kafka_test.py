client = KafkaClient("10.120.180.212:9092")
from pykafka import KafkaClient
client = KafkaClient(zookeeper_hosts="10.120.180.212:2181,10.120.180.213:2181,10.120.180.214:2181")
client.topics
topic = client.topics['testtopic']
last_offset =topic.latest_available_offsets()
print last_offset
partitions = topic.partitions
print partitions
consumer = topic.get_simple_consumer(b"simple_consumer_group", partitions=[partitions[0]])  
# 选择一个分区进行消费        
offset_list = consumer.held_offsets
consumer.consume()
consumer.consume().value.decode()



from pykafka import KafkaClient
client = KafkaClient(zookeeper_hosts="10.120.180.212:2181,10.120.180.213:2181,10.120.180.214:2181")
consumer = client.topics['testtopic'].get_simple_consumer(b"simple_consumer_group", partitions=[client.topics['testtopic'].partitions[0]])




from kafka import KafkaConsumer
consumer = KafkaConsumer('testtopic', bootstrap_servers=['10.120.180.212:9092','10.120.180.213:9092','10.120.180.214:9092'])
for msg in consumer:
    recv = "%s:%d:%d: key=%s value=%s" % (msg.topic, msg.partition, msg.offset, msg.key, msg.value)
    print recv


from kafka import KafkaConsumer
consumer = KafkaConsumer('testtopic', bootstrap_servers=['10.120.180.212:9092'])

for msg in consumer:
    recv = "%s:%d:%d: key=%s value=%s" % (msg.topic, msg.partition, msg.offset, msg.key, msg.value)
    print recv


from kafka import KafkaConsumer
consumer = KafkaConsumer('algo_ad_price_stream', bootstrap_servers=['hzabj-algoqueue3.server.163.org:9092','hzabj-algoqueue5.server.163.org:9092','hzabj-algoqueue6.server.163.org:9092'])
for msg in consumer:
    recv = "%s:%d:%d: key=%s value=%s" % (msg.topic, msg.partition, msg.offset, msg.key, msg.value)
    print recv




10.120.180.212  paramserver1.hz.163.org	
10.120.180.213  paramserver2.hz.163.org	
10.120.180.214  paramserver3.hz.163.org	


bin/kafka-console-producer.sh --broker-list 10.120.180.212:9092,10.120.180.213:9092,10.120.180.214:9092 --topic testtopic3

nohup bin/kafka-server-start.sh config/server.properties &

./zkServer.sh start



./kafka-topics.sh --create --zookeeper 10.120.180.212:2181,10.120.180.213:2181,10.120.180.214:2181 --replication-factor 2 --partitions 1 --topic testtopic3