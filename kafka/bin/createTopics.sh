#!/bin/bash

peg sshcmd-node lrh 1 "kafka-topics.sh --create --zookeeper ec2-54-70-146-1.us-west-2.compute.amazonaws.com:2181 --replication-factor 1 --partitions 1 --topic connect-twitter"

peg sshcmd-node lrh 1 "kafka-topics.sh --create --zookeeper ec2-54-70-146-1.us-west-2.compute.amazonaws.com:2181 --replication-factor 1 --partitions 1 --topic stream-twitter"
