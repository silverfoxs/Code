#! /bin/bash

/snap/bin/multipass list |grep -o '[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}' > ./ip_pool

#/snap/bin/multipass list > ./ip
#for line in $(cat ./ip)
#do
#    echo $( echo $line |grep -o '[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.' |grep -v '^\s*$' )
#done

Netsarang