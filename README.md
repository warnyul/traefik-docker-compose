# Traefik

![deploy](https://github.com/warnyul/traefik-docker-compose/workflows/deploy/badge.svg)

I created this repo for personal use. My goal was to easily publish web applications under my domain name.
Traefik helped me a lot. My applications no matter how and where I want to access them. It works with Swarm for now, but I plan to build my infrastructure with [Kubernetes](https://kubernetes.io) later.

So, this configuration runs a Traefik service in Swarm Mode with following configurations:
* automatic cert resolving with [Let's Encrypt](https://letsencrypt.org),
* global HTTP to HTTPS redirection with STS header,
* global www to non-www redirection,
* and a dashboard, which has been restricted by [Digest Authentication](https://docs.traefik.io/middlewares/digestauth/).

## Requirements

This compose file has been created for my Droplet on Digital Ocean, so you need one, or you just modify the `certresolver` configuration in [docker-compose.acme.yml](docker-compose.acme.yml) file.

## Environment settings

Environment variables are stored in .env files. I know to manage `.env` files are not supported by `docker stack deploy` command. However, I like this idea to manage environment variables with `.env` files. So, I have created two files (`.env`, `.env.dev`). So, I use `source` command to load variables from `.env` files. I have two shell scripts. One for start the application on local machine ([start.sh](./scripts/start.sh)), and another to deploy the application to remote.

I recommend to do not store `.env` file in git. Better, if this is safely stored in CI/CD, Vault or other secret management software.

### For deployment

To deploy this Traefik service, you need to set the following two environment variables before run [deploy.sh](./scripts/deploy.sh). I use Daemon sockets to publish my services to Digital Ocean. If you are not comfortable with this just jump to the [How to use on my server?](./README.md#How-to-use-on-my-server?) to use on my server?) section to read alternative solutions.

* `HOST`: Host without port number for Daemon socket(s) to connect to. The deploy script default connects to the 2376 port.
* `DOCKER_STACK`: A stack name to deploy service with `docker stack deploy` command. It also used for external network definitions.

### Traefik service
* `DOMAIN`: The domain name where Traefik will listen, and it is already used for certificate resolving too.
* `LOG_LEVEL`: Log level of Traefik. Logging levels are `DEBUG`, `PANIC`, `FATAL`, `ERROR`, `WARN`, and `INFO`.
* `DOCKER_STACK`: Used for set `traefik.provider.docker.network` variable.

### Tls (only used in production)
* `ACME_EMAIL`: An email address, which has been used by [ACME](https://github.com/acmesh-official/acme.sh) to create and renew certificates.
* `DO_AUTH_TOKEN`: Digital Ocean authentication token, which has been used by ACME to resolve `CNAME` when creating `dns-01` challenge.

### Traefik Dashboard
* `DASHBOARD_CREDENTIALS`: Credentials to access Traefik's dashboard. Use `htdigest` to generate credentials. For example: `htdigest -c pwd.txt admin traefik`.
* `DASHBOARD_SUBDOMAIN`: Subdomain where you want to access Traefik's dashboard.

## How to run on a local machine?

Before you start the service, you should run `./scripts/setup.sh` to prepare the development environment on your machine.
This will create a DNS server, which makes easy the subdomain management.

After that, run `./scripts/start.sh`.

By default, Traefik's dashboard will be accessible with _admin:admin_ credentials on https://traefik.bvarga.localhost.

## How to use on my server?

First, you should protect Docker daemon sockets on your server. You can use my setup script [here](https://github.com/warnyul/digital-ocean-setup#protect_dockersh), but this just generates some config file without certificates. So, I recommend you to follow the official documentation [here](https://docs.docker.com/engine/security/https/). Do not forget to set up your client certificates as well.

After that, set up environment variables too, based on what you read earlier.

Finally, run `./scripts/deploy.sh`

If you are not comfortable with this, just check out this repo on your server, then set up environment variables and run `./scripts/start.sh`. Just remember this script using `.env.dev` file, so you should set up variables in this file.

## License

Copyright 2020 Balázs Varga

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.