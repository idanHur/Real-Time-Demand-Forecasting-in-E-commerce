#!/bin/bash

# Store the current directory to return to it later
cd ..
CURRENT_DIR=$(pwd)

# Download and extract Zookeeper
wget https://archive.apache.org/dist/zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0-bin.tar.gz
tar -xvzf apache-zookeeper-3.7.0-bin.tar.gz
cd apache-zookeeper-3.7.0-bin/conf
ls
# If zoo.cfg is not present, create one using zoo_sample.cfg as a template
if [ ! -f zoo.cfg ]; then
    cp zoo_sample.cfg zoo.cfg
fi
cd "$CURRENT_DIR" # Return to the original directory
cd apache-zookeeper-3.7.0-bin/bin
sudo ./zkServer.sh start
cd "$CURRENT_DIR" # Return to the original directory

# Extract Kafka
tar -xvzf kafka_2.13-3.2.1.tgz
cd kafka_2.13-3.2.1
# Start Kafka server in the background
./bin/kafka-server-start.sh config/server.properties &
KAFKA_PID=$!
# Sleep for a few seconds to give Kafka time to set up
sleep 10
cd "$CURRENT_DIR" # Return to the original directory

# Extract Spark
tar -xvzf spark-3.3.0-bin-hadoop3.tgz
cd spark-3.3.0-bin-hadoop3/jars
wget https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.12/3.1.2/spark-sql-kafka-0-10_2.12-3.1.2.jar
cd "$CURRENT_DIR" # Return to the original directory
cd Uncovering_Sales_Insights_Idan_Hur_Eyal_Itzhak/
jupyter notebook &
