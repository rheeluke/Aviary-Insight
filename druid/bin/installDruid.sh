#!/usr/bin/env bash

peg sshcmd-cluster luke-rhee-cluster "curl -O http://static.druid.io/artifacts/releases/druid-0.9.1.1-bin.tar.gz"
peg sshcmd-cluster luke-rhee-cluster "tar -xzf druid-0.9.1.1-bin.tar.gz"

peg sshcmd-cluster luke-rhee-cluster "curl -O http://static.druid.io/tranquility/releases/tranquility-distribution-0.8.1.tgz"
peg sshcmd-cluster luke-rhee-cluster "tar -xzf tranquility-distribution-0.8.1.tgz"

for i in 1 2 3 4
do
    peg scp to-rem luke-rhee-cluster i ../src/resources/common.runtime.properties druid-0.9.1.1/conf/druid/_common
done
