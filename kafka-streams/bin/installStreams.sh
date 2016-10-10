#!/usr/bin/env bash

peg sshcmd-node lrh 5 "mkdir kafka-streams"

peg scp to-rem lrh 5 ../resources/streams-1.0.0-standalone.jar kafka-streams
