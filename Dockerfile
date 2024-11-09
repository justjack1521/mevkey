FROM quay.io/keycloak/keycloak:${VERSION} AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${VERSION}

COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Configure runtime options
ENV KC_DB_URL_HOST=postgresql
ENV KC_DB_URL_PORT=5432
ENV KC_DB_URL_DATABASE=openremote
ENV KC_DB_SCHEMA=public
ENV KC_DB_USERNAME=postgres
ENV KC_DB_PASSWORD=postgres
ENV KC_HOSTNAME=mevkey-hqezz.ondigitalocean.app
ENV KC_HTTP_ENABLED=true

EXPOSE 8080

ENTRYPOINT /opt/keycloak/bin/kc.sh ${KEYCLOAK_START_COMMAND:-start}