FROM quay.io/keycloak/keycloak:19.0.1 as base

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_CACHE_STACK=ec2
ENV KC_DB=postgres
ENV KC_HTTP_RELATIVE_PATH=/auth

# Dev
FROM base as dev
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start-dev"]

# Build
FROM base as build

COPY themes/sankt-virtual /opt/keycloak/themes/sankt-virtual
COPY themes/noiV2 /opt/keycloak/themes/noiV2
COPY native-s3-ping/target/native-s3-ping-jar-with-dependencies.jar /opt/keycloak/providers/native-s3-ping-jar-with-dependencies.jar
COPY registration-event-listener/target/registration-event-listener.jar /opt/keycloak/providers/registration-event-listener.jar

RUN /opt/keycloak/bin/kc.sh build

# Prod
FROM base as prod
COPY --from=build /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]
