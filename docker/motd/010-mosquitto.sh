#!/bin/sh

MOSQUITTO_VERSION=$( mosquitto -h )

echo "Mosquitto version: $( echo ${MOSQUITTO_VERSION} | cut -d' ' -f 3 )"
echo "Supported MQTT version: $( echo ${MOSQUITTO_VERSION} | cut -d' ' -f 8 )"
