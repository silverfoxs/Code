#! /bin/bash

#/var/snap/multipass/common/cache/multipassd/vault/images

for i in {1..15}
do
    /snap/bin/multipass launch --name core22-${i} core22 --cpus 2 --memory 1G --disk 4G
done