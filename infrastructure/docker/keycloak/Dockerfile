FROM quay.io/keycloak/keycloak:20.0.1 AS base

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
ENV KC_HTTP_RELATIVE_PATH=/auth

# Dev
FROM base AS dev
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start-dev"]

# Build
FROM base AS build

COPY themes/sankt-virtual /opt/keycloak/themes/sankt-virtual
COPY themes/noiV2 /opt/keycloak/themes/noiV2
COPY themes/noi-community /opt/keycloak/themes/noi-community
#COPY native-s3-ping/target/native-s3-ping-jar-with-dependencies.jar /opt/keycloak/providers/native-s3-ping-jar-with-dependencies.jar
COPY registration-event-listener/target/registration-event-listener.jar /opt/keycloak/providers/registration-event-listener.jar

RUN /opt/keycloak/bin/kc.sh build

# Prod
FROM base AS prod
COPY --from=build /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]
