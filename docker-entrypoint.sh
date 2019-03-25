#!/bin/sh

set -e

# create mosquitto passwordfile
if [ ! -f /mosquitto/config/passwd ]; then
    if ( [ -z "${MQTT_USERNAME}" ] || [ -z "${MQTT_PASSWORD}" ] ); then
      echo "MQTT_USERNAME and/or MQTT_PASSWORD not defined"
      exit 1
    fi

    touch /mosquitto/config/passwd
    mosquitto_passwd \
        -b /mosquitto/config/passwd \
        ${MQTT_USERNAME} \
        ${MQTT_PASSWORD}
fi

# create tls certificates
if [ ! -d /mosquitto/config/certs ]; then
    if [ -z "${CA_COMMON_NAME}" ]; then
      echo "CA_COMMON_NAME certificate Common Name not defined"
      exit 1
    fi

    mosquitto_certs ${CA_COMMON_NAME}
fi

exec "$@"
