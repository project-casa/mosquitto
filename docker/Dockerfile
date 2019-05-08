# https://hub.docker.com/_/eclipse-mosquitto
FROM eclipse-mosquitto:1.6.1

ARG DOCKER_REPO
ARG DOCKER_TAG
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
LABEL maintainer="Roel Schut" \
      description="Mosquitto MQTT Broker" \
      org.label-schema.name=${DOCKER_REPO} \
      org.label-schema.version=${DOCKER_TAG} \
      org.label-schema.build-date=${LABEL_BUILD_DATE} \
      org.label-schema.vcs-ref=${LABEL_VCS_REF} \
      org.label-schema.vcs-url="https://github.com/project-casa/mosquitto" \
      org.label-schema.schema-version="1.0"

COPY docker/mosquitto_certs.sh /usr/bin/mosquitto_certs

RUN set -x && \
    chmod +x /usr/bin/mosquitto_certs && \
    apk add --no-cache \
        openssl \
        mosquitto-clients

COPY docker/mosquitto.conf /mosquitto/
WORKDIR /mosquitto/

COPY docker/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/mosquitto.conf"]
