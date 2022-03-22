FROM quay.io/keycloak/keycloak:17.0.0 as base

# Dev
FROM base as dev
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]

# Build
FROM base as build

COPY infrastructure/docker/keycloak/JDBC_PING.cli /opt/jboss/tools/cli/jgroups/discovery/JDBC_PING.cli
COPY themes/sankt-virtual /opt/jboss/keycloak/themes/sankt-virtual
COPY themes/noiV2 /opt/jboss/keycloak/themes/noiV2
COPY registration-event-listener/target/registration-event-listener-0.0.1-SNAPSHOT.jar /opt/jboss/keycloak/standalone/deployments/registration-event-listener-0.0.1-SNAPSHOT.jar
