#!/usr/bin/env bash

peg sshcmd-node lrh 5 "mkdir kafka-connect-twitter"

peg scp to-rem lrh 5 ../resources/kafka-connect-twitter-0.1-jar-with-dependencies.jar kafka-connect-twitter

peg sshcmd-node lrh 5 "sudo mv kafka-connect-twitter/kafka-connect-twitter-0.1-jar-with-dependencies.jar /usr/share/java"

peg scp to-rem lrh 5 ../resources/connect-simple-source-standalone.properties kafka-connect-twitter

peg scp to-rem lrh 5 ../resources/twitter-source.properties kafka-connect-twitter
