Installation
============

In this section you can find all relevant information on how to install the authentication server. In this guide multiple nodes will be created to guarantee a failsafe system. On every node Docker will be used to host the Keycloak containers. Further, PostgreSQL will be used as a central database. And last, a load balancer will be configured in front of the nodes to distribute the requests accross them.

More detailed description about system requirements and other possible installation methods can be found here: (https://www.keycloak.org/docs/latest/server_installation/)[https://www.keycloak.org/docs/latest/server_installation/].

## Table of content

1. [Prerequisites](#prerequisites)

## Prerequisites

- Database
    - [PostgreSQL](https://www.postgresql.org/)
- Nodes
    - [Docker](https://www.docker.com/)
    - ToDO: Network requirements
- Load balancer

