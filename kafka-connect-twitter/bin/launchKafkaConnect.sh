#!/usr/bin/env bash

peg sshcmd-node lrh 5 "connect-standalone.sh kafka-connect-twitter/connect-simple-source-standalone.properties kafka-connect-twitter/twitter-source.properties &"
