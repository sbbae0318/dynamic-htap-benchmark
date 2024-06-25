#!/bin/bash

rm tpcc*.tar
rm -r tpcc/*
rm target/tpcc*.jar
mvn package -PTpccLoad
mvn package -PTpccRun

cp target/tpcc*.jar tpcc/
cp -r database tpcc/
cp tpcc.properties tpcc/

ip='220.94.140.205'

tar -cvf tpcc.tar tpcc
sshpass -p 'tibero1!' scp tpcc.tar root@$ip:/root/loadScript
sshpass -p 'tibero1!' ssh root@$ip "cd /root/loadScript/ && rm -rf tpcc && tar -xvf tpcc.tar"

