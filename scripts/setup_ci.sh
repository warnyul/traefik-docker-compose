#!/usr/bin/env sh

# Variables
BASEDIR=$(dirname "$0")
PROJECTDIR="$BASEDIR/.."
DOCKER_CONFIG_DIR=$PROJECTDIR/.docker

mkdir -p $DOCKER_CONFIG_DIR

echo $DOCKER_CA >> $DOCKER_CONFIG_DIR/ca.pem
echo $DOCKER_CERT >> $DOCKER_CONFIG_DIR/cert.pem
echo $DOCKER_KEY >> $DOCKER_CONFIG_DIR/key.pem