#!/bin/bash

peg up ./master.yml &
peg up ./workers.yml &

wait

eval `ssh-agent -s`

peg fetch lrh

peg install lrh ssh
peg install lrh aws

peg install lrh zookeeper
peg install lrh kafka
