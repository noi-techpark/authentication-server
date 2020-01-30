Installation
============

In this section you can find all relevant information on how to install the authentication server. In this guide multiple nodes will be created to guarantee a failsafe system. On every node Docker will be used to host the Keycloak containers. Further, PostgreSQL will be used as a central database. And last, a load balancer will be configured in front of the nodes to distribute the requests accross them.

More detailed description about system requirements and other possible installation methods can be found here: [https://www.keycloak.org/docs/latest/server_installation](https://www.keycloak.org/docs/latest/server_installation).

## Table of contents

- [Prerequisites](#prerequisites)
- [Setup nodes](#setup-nodes)
- [Setup firewall](#setup-firewall)
- [Setup nodes](#setup-nodes)
- [Setup load balancer](#setup-load-balancer)
- [Create admin user](#create-admin-user)

## Prerequisites

- Database Server
    - [PostgreSQL](https://www.postgresql.org/)
- SMTP Server
- Nodes
    - [Docker](https://www.docker.com/)
    - [Docker Compose](https://docs.docker.com/compose/)
- Load balancer

All Keycloak nodes should be connected with a private network. There should be no possibility to access the nodes directly through a public IP address. The only public entrypoint should be the load balancer, that receives the requests through his public IP and redirects the requests to the nodes to their private IP addresses. However, the nodes should be able to communicate with each other using the private network.

## Setup firewall

Create a private network an allow the load balancer to access the nodes throgh the port 8080. In addition, allow the nodes to access each other throgh the ports 7600 and 57600.

## Setup nodes

Install Docker on every node and copy the files `docker-compose.run.yml` and `.env.example` onto the server. Rename them to `docker-compose.yml` and `.env` and adjust the configuration in the `.env` file.

Then start the containers by executing the following command:

```bash
docker-compose up -d
```

For more convenience, you can copy the files `server/start.sh` and `server/stop.sh` to your server beside the other files. These helper scripts can help with starting and stoping the container.

## Setup load balancer

The load balancer should accept all HTTP/HTTPS requests and forward them to the Keycloak nodes. The destination port for the nodes is the port 8080. Important is, that the load balancer forwards the requests to the nodes within the private network.

## Create admin user

The first user must be created using the command line on one of the nodes:

```bash
docker-compose exec keycloak /opt/jboss/keycloak/bin/add-user-keycloak.sh -u <USERNAME> -p <PASSWORD>
```
