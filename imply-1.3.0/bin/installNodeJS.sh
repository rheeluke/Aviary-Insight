#!/usr/bin/env bash

peg sshcmd-cluster lrh "sudo apt-get update"

peg sshcmd-cluster lrh "curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - "
peg sshcmd-cluster lrh "sudo apt-get install -y nodejs"
peg sshcmd-cluster lrh "sudo apt-get install -y build-essential"
