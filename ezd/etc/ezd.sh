#!/bin/bash
#Bug in docker, for some reason must specify explicitly
export DOCKER_COMMANDS="/root/start.sh"
export DOCKER_ARGS=" -p ${EASYDEPLOY_HOST_IP}:80:9292 "
export EASYDEPLOY_PORTS="9200 514 12201 4712 7007 7008"
export EASYDEPLOY_EXTERNALPORTS="80"
export EASYDEPLOY_PROCESS_NUMBER=1
export EASYDEPLOY_STATE="stateful"
export EASYDEPLOY_SERVICE_CHECK_INTERVAL=60s
export DOCKER_IMAGE="cazcade/logstash"