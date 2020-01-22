# Authentication Server

A central authentication server for all services build with the open source identity and access management tool Keycloak [https://www.keycloak.org/](https://www.keycloak.org/).

A basic explanation of the terms and standards used by Keycloak can be found in the documentation about [OAuth 2.0 and OpenID Connect](docs/oauth2-and-openid-connect.md).

## Table of contents

- [Getting started](#getting-started)
- [Setup and configuration](#setup-and-configuration)
- [Deployment](#deployment)
- [Information](#information)

## Getting started

These instructions will get you a copy of the project up and running
on your local machine for development and testing purposes.

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

### Start and stop the containers

Before start working you have to start the Docker containers:

```
docker-compose up --build --detach
```

After finished working you can stop the Docker containers:

```
docker-compose stop
```

The website will be accessible at [http://localhost:8080/](http://localhost:8080/). The default username for the master realm is "admin" and the password "password".

### SMTP Server

In order to test the whole workflow locally, [Mailhog](https://github.com/mailhog/MailHog) is set up and can be configured as SMTP server that catches all outgoing mails. These are the SMTP configurations:

- Host: mailhog
- Port: 1025

All catched emails can be visited at [http://localhost:8025/](http://localhost:8025/).

## Setup and configuration

By default the authentication server has no applications configured. That's why you can find in the documentation a detailed description on [how to set up and configure the server](docs/noi-authentication-server.md).

In addition, example application where you can take a look how to integrate your application with the authentication server can be found in this repository: [https://github.com/noi-techpark/authentication-examples](https://github.com/noi-techpark/authentication-examples).

## Deployment

To deploy the app, you must first create the production Docker image. This can be done using the `docker-compose.build.yml` file. Therefore, duplicate first the file `.env.build.example` to `.env` and then set the environment variables "DOCKER_IMAGE" and "DOCKER_TAG". Last, you can create and push the image using the following commands:

```bash
docker-compose -f docker-compose.build.yml build
docker-compose -f docker-compose.build.yml push
```

For a detailed installation instruction of the production servers, you can check out the [installation documentation](docs/installation.md).

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
