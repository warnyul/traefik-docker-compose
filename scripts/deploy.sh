#!/usr/bin/env sh

# Variables
BASEDIR=$(dirname "$0")
PROJECTDIR="$BASEDIR/.."

set -a # automatically export all variables
source $PROJECTDIR/.env
set +a

docker \
  --tlsverify \
  -H=$HOST:2376 \
  --tlscacert=$PROJECTDIR/.docker/ca.pem \
  --tlscert=$PROJECTDIR/.docker/cert.pem \
  --tlskey=$PROJECTDIR/.docker/key.pem \
  stack deploy $DOCKER_STACK \
  -c $PROJECTDIR/docker-compose.yml \
  -c $PROJECTDIR/docker-compose.tls.yml