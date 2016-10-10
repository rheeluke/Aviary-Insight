#!/bin/bash

peg sshcmd-node lrh 1 "curl -XPOST -H'Content-Type: application/json' -d @quickstart/tweets-kafka-supervisor.json http://ec2-54-70-146-1.us-west-2.compute.amazonaws.com:8090/druid/indexer/v1/supervisor"


#curl -XPOST -H'Content-Type: application/json' -d @quickstart/tweets-kafka-supervisor.json http://ec2-54-70-146-1.us-west-2.compute.amazonaws.com:8090/druid/indexer/v1/supervisor

#curl -XGET http://ec2-54-70-146-1.us-west-2.compute.amazonaws.com:8090/druid/indexer/v1/supervisor

#curl -XPOST http://ec2-54-70-146-1.us-west-2.compute.amazonaws.com:8090/druid/indexer/v1/supervisor/wikiticker-kafka/shutdown

#curl -L -H'Content-Type: application/json' -XPOST --data-binary @tweets-top.json http://ec2-54-71-20-46.us-west-2.compute.amazonaws.com:8082/druid/v2/

#export KAFKA_OPTS="-Dfile.encoding=UTF-8"

#bin/generate-pivot-config --druid ec2-54-71-20-46.us-west-2.compute.amazonaws.com:8082 --with-comments > myconfig.yaml

#kafka-console-producer.sh --broker-list localhost:9092 --topic stream-twitter
# {"created_at":"2016-01-01T00:00:00Z","hashtags":["marry","larry"]}
# {"created_at":"2016-01-01T00:00:06Z","hashtags":["marry","larry2"]}
