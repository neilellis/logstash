#!/bin/bash -x
cd /root
export HOME=/root
/root/logstash-1.4.1/bin/logstash agent -f /root/logstash.conf -- web  &
while :
do
    curator delete --disk-space 100
    sleep 1200
done