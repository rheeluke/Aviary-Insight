#!/usr/bin/env bash


# Start the application in class `com.example.MyStreamsApp`
# from the fat jar named `path-to-app-fatjar.jar`.
peg sshcmd-node lrh 5 "java -cp kafka-streams/streams-1.0.0-standalone.jar rheeluke.streams.TwitterStream"
