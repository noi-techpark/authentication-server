FROM jboss/keycloak:12.0.3 as base

# Dev
FROM base as dev

RUN sed -i -e "s%<staticMaxAge>2592000</staticMaxAge>%<staticMaxAge>-1</staticMaxAge>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
    sed -i -e "s%<cacheThemes>true</cacheThemes>%<cacheThemes>false</cacheThemes>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
    sed -i -e "s%<cacheTemplates>true</cacheTemplates>%<cacheTemplates>false</cacheTemplates>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml

# Build
FROM base as build

COPY infrastructure/docker/keycloak/JDBC_PING.cli /opt/jboss/tools/cli/jgroups/discovery/JDBC_PING.cli
COPY themes/sankt-virtual /opt/jboss/keycloak/themes/sankt-virtual
COPY themes/noiV2 /opt/jboss/keycloak/themes/noiV2
COPY registration-event-listener/target/registration-event-listener-0.0.1-SNAPSHOT.jar /opt/jboss/keycloak/standalone/deployments/registration-event-listener-0.0.1-SNAPSHOT.jar
