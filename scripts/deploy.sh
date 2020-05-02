#!/usr/bin/env bash

# Variables
BASEDIR=$(dirname "$0")
PROJECTDIR=${BASEDIR}/..
DOCKER_CONFIG_DIR=${PROJECTDIR}/.docker

set -a # automatically export all variables
source ${PROJECTDIR}/.env
set +a

if [[ "${SWARM_MODE}" = "true" ]]; then
    DOCKER_NETWORK_DRIVER="overlay" docker \
                                      -H=${HOST}:2376 \
                                      --tlsverify \
                                      --tlscacert=${DOCKER_CONFIG_DIR}/ca.pem \
                                      --tlscert=${DOCKER_CONFIG_DIR}/cert.pem \
                                      --tlskey=${DOCKER_CONFIG_DIR}/key.pem \
                                      stack deploy "${DOCKER_STACK}" \
                                      -c ${PROJECTDIR}/docker-compose.yml \
                                      -c ${PROJECTDIR}/docker-compose.acme.yml
else
    DOCKER_NETWORK_DRIVER="bridge" docker-compose \
                                      -f ${PROJECTDIR}/docker-compose.yml \
                                      -f ${PROJECTDIR}/docker-compose.acme.yml \
                                      -p "${DOCKER_STACK}" \
                                      -H=${HOST}:2376 \
                                      --tlsverify \
                                      --tlscacert=${DOCKER_CONFIG_DIR}/ca.pem \
                                      --tlscert=${DOCKER_CONFIG_DIR}/cert.pem \
                                      --tlskey=${DOCKER_CONFIG_DIR}/key.pem \
                                      up
fi

