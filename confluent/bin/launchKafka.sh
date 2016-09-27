#!/usr/bin/env bash

peg sshcmd-node luke-rhee-cluster 2 "sudo /usr/bin/connect-standalone /etc/kafka-connect-twitter/connect-source-standalone.properties /etc/kafka-connect-twitter/twitter-source.properties"
