#!/usr/bin/env sh

# Variables
BASEDIR=$(dirname "$0")

set -a # automatically export all variables
source ${BASEDIR}/../.env 2> /dev/null
source ${BASEDIR}/../.env.dev
set +a

docker stack deploy $DOCKER_STACK -c ${BASEDIR}/../docker-compose.yml