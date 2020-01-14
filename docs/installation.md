Installation
============

In this section you can find all relevant information on how to install the authentication server. In this guide multiple nodes will be created to guarantee a failsafe system. On every node Docker will be used to host the Keycloak containers. Further, PostgreSQL will be used as a central database. And last, a load balancer will be configured in front of the nodes to distribute the requests accross them.

More detailed description about system requirements and other possible installation methods can be found here: (https://www.keycloak.org/docs/latest/server_installation/)[https://www.keycloak.org/docs/latest/server_installation/].

## Table of content

- [Prerequisites](#prerequisites)
- [Admin user](#admin-user)

## Prerequisites

- Database Server
    - [PostgreSQL](https://www.postgresql.org/)
- SMTP Server
- Nodes
    - [Docker](https://www.docker.com/)
    - ToDo: Network requirements
- Load balancer

## Admin user

The first user must be created using the command line on one of the nodes:

```bash
docker-compose exec keycloak /opt/jboss/keycloak/bin/add-user-keycloak.sh -u <USERNAME> -p <PASSWORD>
```
