FROM jboss/keycloak:8.0.0

RUN sed -i -e "s%<staticMaxAge>2592000</staticMaxAge>%<staticMaxAge>-1</staticMaxAge>%" /opt/jboss/keycloak/standalone/configuration/standalone.xml && \
    sed -i -e "s%<cacheThemes>true</cacheThemes>%<cacheThemes>false</cacheThemes>%" /opt/jboss/keycloak/standalone/configuration/standalone.xml && \
    sed -i -e "s%<cacheTemplates>true</cacheTemplates>%<cacheTemplates>false</cacheTemplates>%" /opt/jboss/keycloak/standalone/configuration/standalone.xml

RUN sed -i -e "s%<staticMaxAge>2592000</staticMaxAge>%<staticMaxAge>-1</staticMaxAge>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
    sed -i -e "s%<cacheThemes>true</cacheThemes>%<cacheThemes>false</cacheThemes>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
    sed -i -e "s%<cacheTemplates>true</cacheTemplates>%<cacheTemplates>false</cacheTemplates>%" /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml

