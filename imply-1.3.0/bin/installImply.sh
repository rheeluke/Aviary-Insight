#!/bin/bash

for i in 1 2 3 4
do
    peg sshcmd-node lrh ${i} "curl -O https://static.imply.io/release/imply-1.3.0.tar.gz"
    peg sshcmd-node lrh ${i} "tar -xzf imply-1.3.0.tar.gz"
    peg sshcmd-node lrh ${i} "rm -rf /home/ubuntu/imply-1.3.0/conf"
    peg scp to-rem lrh ${i} ../resources/conf /home/ubuntu/imply-1.3.0
done
