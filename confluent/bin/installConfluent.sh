#!/usr/bin/env bash

peg sshcmd-cluster luke-rhee-cluster "sudo apt-get update &"
peg sshcmd-cluster luke-rhee-cluster "wget -qO - http://packages.confluent.io/deb/3.0/archive.key | sudo apt-key add - &"
peg sshcmd-cluster luke-rhee-cluster 'sudo add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/3.0 stable main &"'
peg sshcmd-cluster luke-rhee-cluster "sudo apt-get update && sudo apt-get install confluent-platform-2.11 &"
