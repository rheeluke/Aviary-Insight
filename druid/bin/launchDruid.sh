#!/usr/bin/env bash

peg sshcmd-node luke-rhee-cluster 1 "java `cat druid-0.9.1.1/conf/druid/coordinator/jvm.config | xargs` -cp druid-0.9.1.1/conf/druid/_common:conf/druid/coordinator:lib/* io.druid.cli.Main server coordinator &"

peg sshcmd-node luke-rhee-cluster 1 "java `cat druid-0.9.1.1/conf/druid/overlord/jvm.config | xargs` -cp druid-0.9.1.1/conf/druid/_common:conf/druid/overlord:lib/* io.druid.cli.Main server overlord &"

peg sshcmd-node luke-rhee-cluster 2 "java `cat druid-0.9.1.1/conf/druid/historical/jvm.config | xargs` -cp druid-0.9.1.1/conf/druid/_common:conf/druid/historical:lib/* io.druid.cli.Main server historical &"

peg sshcmd-node luke-rhee-cluster 2 "java `cat druid-0.9.1.1/conf/druid/middleManager/jvm.config | xargs` -cp druid-0.9.1.1/conf/druid/_common:conf/druid/middleManager:lib/* io.druid.cli.Main server middleManager &"

peg sshcmd-node luke-rhee-cluster 2 "tranquility-distribution-0.8.1/bin/tranquility kafka -configFile druid-0.9.1.1/conf/tranquility/kafka.json &"

peg sshcmd-node luke-rhee-cluster 3 "java `cat druid-0.9.1.1/conf/druid/broker/jvm.config | xargs` -cp druid-0.9.1.1/conf/druid/_common:conf/druid/broker:lib/* io.druid.cli.Main server broker &"

peg sshcmd-node luke-rhee-cluster 4 "java `cat druid-0.9.1.1/conf/druid/broker/jvm.config | xargs` -cp druid-0.9.1.1/conf/druid/_common:conf/druid/broker:lib/* io.druid.cli.Main server broker &"
