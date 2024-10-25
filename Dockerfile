FROM quay.io/keycloak/keycloak:26.0.0 AS builder

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build \
    --db=postgres \
    --transaction-xa-enabled=true \
    --health-enabled=true \
    --metrics-enabled=true


FROM quay.io/keycloak/keycloak:26.0.0

COPY --from=builder /opt/keycloak/ /opt/keycloak/

COPY keycloak-magic-link-0.29-SNAPSHOT.jar /opt/keycloak/providers/keycloak-magic-link-0.29-SNAPSHOT.jar

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]