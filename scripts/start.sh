#!/usr/bin/env sh

# Variables
BASEDIR=$(dirname "$0")

set -a # automatically export all variables
source ${BASEDIR}/../.env
source ${BASEDIR}/../.env.dev
set +a

docker stack deploy $DOCKER_STACK -c ${BASEDIR}/../docker-compose.yml