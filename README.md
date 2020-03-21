# bvarga.dev-proxy

Treafik proxy configuration for my personal website

## Configurations

Configurations have been stored in env files:
* `.env` file contains configurations for production environment.
* `.dev.env` file contains configurations for the development environment. Overrides the production environments

Environment variables:
* `DOMAIN`: A domain name where traefik will listen
* `LOG_LEVEL`: Log level of Traefik. Logging levels are `DEBUG`, `PANIC`, `FATAL`, `ERROR`, `WARN`, and `INFO`.
* `DASHBOARD_CREDENTIALS`: Credentials for access dashboard
* `DASHBOARD_SUBDOMAIN`: Subdomain where dashboard will be accessible

## Development Environment

By default Treafik's dashboard will be accessible with _admin:admin_ credentials on https://traefik.bvarga-local.

Run `./scripts/setup.sh` for prepare development enviroment on your machine.
It will create a dns server for easy subdomain management.

After that, run `./scripts/setup.sh`

## Production

You should set two environment variables:
* `DASHBOARD_CREDENTIALS`: Use `htdigest` to generate credentials. For example: `htdigest -c admin traefik`.
* `DASHBOARD_SUBDOMAIN`: Subdomain, where you want to access Traefik's dashboard.