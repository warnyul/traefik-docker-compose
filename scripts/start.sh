#!/usr/bin/env bash

# Variables
BASEDIR=$(dirname "$0")

set -a # automatically export all variables
source ${BASEDIR}/../.env 2> /dev/null
source ${BASEDIR}/../.env.dev
set +a

if [[ "${SWARM_MODE}" = "true" ]]; then
    DOCKER_NETWORK_DRIVER="overlay" docker stack deploy "${DOCKER_STACK}" -c ${BASEDIR}/../docker-compose.yml
else
    DOCKER_NETWORK_DRIVER="bridge" docker-compose -f ${BASEDIR}/../docker-compose.yml -p "${DOCKER_STACK}" up 
fi