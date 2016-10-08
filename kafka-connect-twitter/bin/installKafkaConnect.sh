#!/usr/bin/env bash

peg scp to-rem lrh 5
 ../resources/kafka-connect-twitter-0.1-jar-with-dependencies.jar Downloads

peg sshcmd-node luke-rhee-cluster 2 "sudo mv Downloads/kafka-connect-twitter-0.1-jar-with-dependencies.jar /usr/share/java/kafka"

peg sshcmd-node luke-rhee-cluster 2 "sudo mkdir /etc/kafka-connect-twitter"

peg scp to-rem luke-rhee-cluster 2 ../resources/connect-simple-source-standalone Downloads

peg sshcmd-node luke-rhee-cluster 2 "sudo mv Downloads/connect-simple-source-standalone /etc/kafka-connect-twitter"

peg scp to-rem luke-rhee-cluster 2 ../resources/twitter-source.properties Downloads

peg sshcmd-node luke-rhee-cluster 2 "sudo mv Downloads/twitter-source.properties /etc/kafka-connect-twitter"
