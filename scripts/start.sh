#!/usr/bin/env sh

# Variables
BASEDIR=$(dirname "$0")

set -a # automatically export all variables
source .env
source .dev.env
set +a

docker stack deploy bvarga-proxy -c ${BASEDIR}/../docker-compose.yml