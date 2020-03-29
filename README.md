# Traefik

![deploy](https://github.com/warnyul/traefik-docker-compose/workflows/deploy/badge.svg)

This configuration runs a Traefik service in Swarm Mode with following configurations:
* automatic cert resolving with [Let's Encrypt](https://letsencrypt.org)
* and a dashboard, which has been restricted by [Digest Authentication](https://docs.traefik.io/middlewares/digestauth/).

## Configurations

Configurations are stored in .env files:
* `.env`: It is used to define enviromnent variables for the production environment. It has been configured on CI/CD.
* `.env.dev`: It is used to define enviromnent variables for the development environment.

## Environment variables:
### For deployment
These configurations are used in the [deploy.sh](./scripts/deploy.sh) to publish Traefik service.
* `HOST`: Hostname for Docker Daemon sockets.
* `DOCKER_STACK`: A stack name to deploy service with `docker stack deploy` command. It also used for external network definitions.

### Traefik service
* `DOMAIN`: A domain name where Traefik will listen, and this configuration is used for cert resolving too.
* `LOG_LEVEL`: Log level of Traefik. Logging levels are `DEBUG`, `PANIC`, `FATAL`, `ERROR`, `WARN`, and `INFO`.

### Tls (only used in production)
* `ACME_EMAIL`: An email address, which has been used by [ACME](https://github.com/acmesh-official/acme.sh) to renew Tls certificates.
* `DO_AUTH_TOKEN`: Digital Ocean authentication token, which has been used by ACME to provisioning a DNS record on Digital Ocean.

### Traefik Dashboard
* `DASHBOARD_CREDENTIALS`: Credentials to access Traefik's dashboard. Use `htdigest` to generate credentials. For example: `htdigest -c pwd.txt admin traefik`.
* `DASHBOARD_SUBDOMAIN`: Subdomain where you want to access Traefik's dashboard.

## Setup Development Environment

By default, Traefik's dashboard will be accessible with _admin:admin_ credentials on https://traefik.bvarga.localhost.

Run `./scripts/setup.sh` for prepare development environment on your machine.
It will create a DNS server for easy subdomain management.

After that, run `./scripts/setup.sh`