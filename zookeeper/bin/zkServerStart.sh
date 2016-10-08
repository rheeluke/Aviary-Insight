#!/bin/bash

for i in 5 6 7 8
do
    peg sshcmd-node lrh ${i} ". ~/.profile; zkServer.sh start"
done
