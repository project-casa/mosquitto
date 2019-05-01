# https://hub.docker.com/_/eclipse-mosquitto
FROM eclipse-mosquitto:1.6.1

COPY mosquitto_certs.sh /usr/bin/mosquitto_certs

RUN set -x && \
    chmod +x /usr/bin/mosquitto_certs && \
    apk add --no-cache \
        openssl \
        mosquitto-clients

COPY mosquitto.conf /mosquitto/
WORKDIR /mosquitto/

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/mosquitto.conf"]
