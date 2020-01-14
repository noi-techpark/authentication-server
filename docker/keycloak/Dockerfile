FROM jboss/keycloak:8.0.1 as base

FROM base as dev

RUN sed -i -e "s%<staticMaxAge>2592000</staticMaxAge>%<staticMaxAge>-1</staticMaxAge>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
    sed -i -e "s%<cacheThemes>true</cacheThemes>%<cacheThemes>false</cacheThemes>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
    sed -i -e "s%<cacheTemplates>true</cacheTemplates>%<cacheTemplates>false</cacheTemplates>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml

FROM base as build

COPY themes/noi /opt/jboss/keycloak/themes/noi
