FROM quay.io/keycloak/keycloak:latest as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://mobius-do-user-7620299-0.b.db.ondigitalocean.com:25060/kc_db
ENV KC_DB_USERNAME=doadmin
ENV KC_DB_PASSWORD=kljbn14vu5fcn15s
ENV KC_HOSTNAME=localhost
ENV KC_HOSTNAME_ADMIN=mevkey-hqezz.ondigitalocean.app/auth
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_HOSTNAME_DEBUG=true

WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start-dev"]