# Authentication Server

A central authentication server for all services build with the open source identity and access managment tool Keycloak [https://www.keycloak.org/](https://www.keycloak.org/).

## Table of contents

- [Gettings started](#getting-started)
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

### SMTP Server

In order to test the whole workflow locally, [Mailhog](https://github.com/mailhog/MailHog) is set up and can be configured as SMTP server that catches all outgoing mails. These are the SMTP configurations:

- Host: mailhog
- Port: 1025

All catched emails can be visited at [http://localhost:8025/](http://localhost:8025/).

### Custom domain

If you wish to run the environment locally with a custom domain and using HTTPS then check out the Docker Compose file [docker-compose.aboutbits.yml](docker-compose.aboutbits.yml). You can run all the previous commands by referencing the custom Docker Compose file:

```bash
docker-compose -f docker-compose.aboutbits.yml up --build --detach
docker-compose -f docker-compose.aboutbits.yml stop
```

However, this setup requires the [Local Docker Environment](https://github.com/aboutbits/local-environment) so that the requests are routed to the right Docker container though a Traefik proxy.

In addition, this setup requires the following entry in the `/etc/hosts` file:

```
127.0.0.1 auth.aboutbits.local
```

## Deployment

ToDo: A detailed description about how the application must be deployed.

## Information

### Support

ToDo: For support, please contact [info@opendatahub.bz.it](mailto:info@opendatahub.bz.it).

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
