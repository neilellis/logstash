#!/bin/bash
cd /root
export HOME=/var/easydeploy/share
/root/logstash-1.4.1/bin/logstash agent -f /root/logstash.conf -- web  &
while :
do
    curator --curation-style space -g 5
    sleep 120
done