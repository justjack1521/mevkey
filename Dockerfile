FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

#COPY keycloak.crt /opt/keycloak/conf/keycloak.crt
#COPY keycloak.pem /opt/keycloak/conf/keycloak.pem
#COPY server.keystore /opt/keycloak/conf/server.keystore
#
#ENV KC_HTTPS_CERTIFICATE_FILE=/opt/keycloak/keycloak-server.crt.pem
#ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/opt/keycloak/keycloak-server.key.pem

ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://mobius-do-user-7620299-0.b.db.ondigitalocean.com:25060/kc_db
ENV KC_DB_USERNAME=doadmin
ENV KC_DB_PASSWORD=kljbn14vu5fcn15s
ENV KC_HOSTNAME=localhost

WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start-dev"]