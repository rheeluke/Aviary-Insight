#!/bin/bash

peg up ./master.yml &
peg up ./workers.yml &

wait

eval `ssh-agent -s`

peg fetch luke-rhee-cluster

peg install luke-rhee-cluster ssh
peg install luke-rhee-cluster aws
peg install luke-rhee-cluster hadoop
