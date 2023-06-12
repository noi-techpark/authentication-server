<!--
SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>

SPDX-License-Identifier: CC0-1.0
-->

# Authentication Server

![REUSE Compliance](https://github.com/noi-techpark/authentication-server/actions/workflows/reuse.yml/badge.svg)

A central authentication server for all services build with the open source identity and access management tool Keycloak [https://www.keycloak.org/](https://www.keycloak.org/).

A basic explanation of the terms and standards used by Keycloak can be found in the documentation about [OAuth 2.0 and OpenID Connect](docs/oauth2-and-openid-connect.md).

## Table of contents

- [Getting started](#getting-started)
- [Setup and configuration](#setup-and-configuration)
- [Deployment](#deployment)
- [Applications / Clients](#applications-clients)
- [Information](#information)
- [Identity broker](#identity-broker)

## Getting started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

To build the project, the following prerequisites must be met:

- [Docker](https://www.docker.com/) 19.x
- [Docker Compose](https://docs.docker.com/compose/)

### Source code

Get a copy of the repository:

```bash
git clone https://github.com/noi-techpark/authentication-server.git
```

Change directory:

```bash
cd authentication-server/
```

### Setup

In order that the authentication server works correctly, you have to perform two setup steps before starting.

First, you have to add the following line to your `/etc/hosts` file of your machine:

```
127.0.0.1 keycloak
```

Second, you have to create a Docker network:

```bash
docker network create authentication
```

### Start and stop the containers

Before start working you have to start the Docker containers:

```bash
docker-compose up --build --detach
```

After finished working you can stop the Docker containers:

```bash
docker-compose stop
```

The website will be accessible at [http://localhost:8080/](http://localhost:8080/). The default username for the master realm is "admin" and the password "password".

### SMTP Server

In order to test the whole workflow locally, [Mailhog](https://github.com/mailhog/MailHog) is set up and can be configured as SMTP server that catches all outgoing mails. These are the SMTP configurations:

- Host: mailhog
- Port: 1025

All catched emails can be visited at [http://localhost:8025/](http://localhost:8025/).

### Themes

If you want to make some adjustments to the theme, you can run the following commands, so that all CSS files will be regenerated on the fly:

```bash
cd themes/noiV2/common/resources
npm install
npm run watch
```

Or you can run it also inside a Docker container:

```bash
docker run --rm -it -v $PWD:/code -w /code/themes/noiV2/common/resources node:16 npm install
docker run --rm -it -v $PWD:/code -w /code/themes/noiV2/common/resources node:16 npm run watch
```

## Setup and configuration

By default the authentication server has no applications configured. That's why you can find in the documentation a detailed description on [how to set up and configure the server](docs/noi-authentication-server.md).

In addition, example application where you can take a look how to integrate your application with the authentication server can be found in this repository: [https://github.com/noi-techpark/authentication-examples](https://github.com/noi-techpark/authentication-examples).

## Deployment

To deploy the app, you must first create the production Docker image. This can be done using the `docker-compose.build.yml` file. Therefore, duplicate first the file `.env.build.example` to `.env` and then set the environment variables "DOCKER_IMAGE" and "DOCKER_TAG". Last, you can create and push the image using the following commands:

```bash
docker-compose -f docker-compose.build.yml build
docker-compose -f docker-compose.build.yml push
```

For a detailed installation instruction of the production servers, you can check out the [installation documentation](docs/installation.md) and [upgrade documentation](docs/upgrade.md).

## Applications / Clients

If you want to configure different tools and applications to provide the authentication using the authentication server, you have to make different configurations and adjustments. Detailed information about different tools can be found [here](#/docs/applications.md).

## Identity broker

Learn how you can configure a keycloak installation as an identity broker.
More details can be found [here](#/docs/indentity-broker.md)

## Information

### Support

For support, please contact [info@opendatahub.bz.it](mailto:info@opendatahub.bz.it).

### Contributing

If you'd like to contribute, please follow the following instructions:

- Fork the repository.

- Checkout a topic branch from the `development` branch.

- Make sure the tests are passing.

- Create a pull request against the `development` branch.

A more detailed description can be found here: [https://github.com/noi-techpark/documentation/blob/master/contributors.md](https://github.com/noi-techpark/documentation/blob/master/contributors.md).

### Documentation

More documentation can be found at [https://opendatahub.readthedocs.io/en/latest/index.html](https://opendatahub.readthedocs.io/en/latest/index.html).

### License

The code in this project is licensed under the GNU AFFERO GENERAL PUBLIC LICENSE Version 3 license. See the [LICENSE.md](LICENSE.md) file for more information.

### REUSE

This project is [REUSE](https://reuse.software) compliant, more information about the usage of REUSE in NOI Techpark repositories can be found [here](https://github.com/noi-techpark/odh-docs/wiki/Guidelines-for-developers-and-licenses#guidelines-for-contributors-and-new-developers).

Since the CI for this project checks for REUSE compliance you might find it useful to use a pre-commit hook checking for REUSE compliance locally. The [pre-commit-config](.pre-commit-config.yaml) file in the repository root is already configured to check for REUSE compliance with help of the [pre-commit](https://pre-commit.com) tool.

Install the tool by running:
```bash
pip install pre-commit
```
Then install the pre-commit hook via the config file by running:
```bash
pre-commit install
```
