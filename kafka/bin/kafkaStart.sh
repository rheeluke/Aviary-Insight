#!/bin/bash

node="$1"
peg sshcmd-node lrh $node "sudo /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties &"

#for i in 1 5 6 7 8
#do
#    peg sshcmd-node lrh ${i} "sudo /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties &"
#done

#peg sshcmd-node lrh 1 "sudo /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties &"
#peg sshcmd-node lrh 1 "sudo /usr/local/kafka/bin/kafka-server-stop.sh &"

#sudo /usr/local/kafka/bin/kafka-server-stop.sh
