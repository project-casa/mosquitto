# https://hub.docker.com/_/eclipse-mosquitto
FROM eclipse-mosquitto:1.5.6

COPY mosquitto.conf /mosquitto/
COPY mosquitto_certs.sh /usr/bin/mosquitto_certs

RUN set -x && \
    apk --no-cache add --virtual deps && \
    apk add \
        openssl \
        mosquitto-clients \
        && \
    apk del deps && \
    chmod +x /usr/bin/mosquitto_certs

WORKDIR /mosquitto/

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/mosquitto.conf"]
