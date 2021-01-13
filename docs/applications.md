Applications
============

If you want to configure different tools and applications to provide the authentication using the authentication server, you have to make different configurations and adjustments. In this document you can find configurations for specific tools.

## Table of contents

- [Grafana](#grafana)


## Grafana

### Installation

First, you have to create a Keycloak client for Grafana:

![Keycloak Grafana Client](images/grafana-client.png)

Second, create the roles "Admin", "Editor" and "Viewer" for the client:

![Keycloak Grafana Roles](images/grafana-roles.png)

Next, create a mapper for the client:

![Keycloak Grafana Mapper](images/grafana-mapper.png)

Finally, adjust the Grafana configuration:

```yml
version: "3.4"

services:
  grafana:
    image: grafana/grafana:7.3.6
    restart: unless-stopped
    user: ${GRAFANA_UID}
    volumes:
    - ./data:/var/lib/grafana:rw
    environment:
      GF_SECURITY_DISABLE_GRAVATAR: "true"
      GF_SERVER_ROOT_URL: "https://grafana.testingmachine.eu"
      GF_USERS_ALLOW_ORG_CREATE: "false"
      GF_USERS_ALLOW_SIGN_UP: "false"

      GF_AUTH_DISABLE_LOGIN_FORM: "true"
      GF_AUTH_BASIC_ENABLED: "false"
      GF_AUTH_GENERIC_OAUTH_ENABLED: "true"
      GF_AUTH_GENERIC_OAUTH_NAME: "NOI Authentication Server"
      GF_AUTH_GENERIC_OAUTH_ALLOW_SIGN_UP: "true"
      GF_AUTH_GENERIC_OAUTH_CLIENT_ID: "grafana"
      GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET: ""
      GF_AUTH_GENERIC_OAUTH_SCOPES: "openid profile email roles"
      GF_AUTH_GENERIC_OAUTH_AUTH_URL: "https://auth.opendatahub.bz.it/auth/realms/noi/protocol/openid-connect/auth"
      GF_AUTH_GENERIC_OAUTH_TOKEN_URL: "https://auth.opendatahub.bz.it/auth/realms/noi/protocol/openid-connect/token"
      GF_AUTH_GENERIC_OAUTH_API_URL: "https://auth.opendatahub.bz.it/auth/realms/noi/protocol/openid-connect/userinfo"
      GF_AUTH_GENERIC_OAUTH_ROLE_ATTRIBUTE_PATH: "contains(roles[*], 'Admin') && 'Admin' || contains(roles[*], 'Editor') && 'Editor' || 'Viewer'"

      GF_SMTP_ENABLED: "true"
      GF_SMTP_HOST: ""
      GF_SMTP_USER: ""
      GF_SMTP_PASSWORD: ""
      GF_SMTP_FROM_ADDRESS: "grafana@testingmachine.eu"
      GF_SMTP_FROM_NAME: "Grafana"

      GF_INSTALL_PLUGINS: "grafana-polystat-panel,vonage-status-panel"
    ports:
    - "3000:3000"
```

### Configuration

