Mosquitto MQTT broker
=====================

[![Latest release][latest-release-img]][latest-release-url]
[![Build status][build-status-img]][build-status-url]
![Layers][image-layers-img]
![Image size][image-size-img]

[latest-release-img]: https://img.shields.io/github/release/project-casa/mosquitto.svg?label=latest
[latest-release-url]: https://github.com/project-casa/mosquitto/releases
[build-status-img]: https://img.shields.io/docker/cloud/build/roeldev/casa-mosquitto.svg
[build-status-url]: https://hub.docker.com/r/roeldev/casa-mosquitto/builds
[image-layers-img]: https://img.shields.io/microbadger/layers/layers/roeldev%2Fcasa-mosquitto/latest.svg
[image-size-img]: https://img.shields.io/microbadger/image-size/image-size/roeldev%2Fcasa-mosquitto/latest.svg

This Docker image adds a default password and creates CA and server certificates so the MQTT broker can be accessed
over SSL/TLS. It also adds some default configs for websockets and logging.


### Ports
| Port | Connection |
|------|------------|
|```1883```| Default
|```8883```| SSL/TLS
|```9001```| Websockets

### Volumes
| Path | Contains |
|------|----------|
|```/mosquitto/config```| Custom config files
|```/mosquitto/data```  | Stored data
|```/mosquitto/log```   | Log files

### Environment variables
| Env. variable | Description |
|---------------|-------------|
|```MQTT_USERNAME```| Default username
|```MQTT_PASSWORD```| Default password
|```CA_COMMON_NAME```| Certificate Authority Common Name 

## Creating certificates with `mosquitto_certs`
Run ```mosquitto_certs [-o] [cn]``` in the Docker container to create new certificates.

### Options
- `-o` overwrite existing certificates

### Examples
`mosquitto_certs 192.168.0.254` Creates new certificates using the ip address as common name.
`mosquitto_certs -o mqtt.local.lan` Creates and overwrites any existing certificates using the given domain name.


## Links
- Github: https://github.com/project-casa/mosquitto
- Docker hub: https://hub.docker.com/r/roeldev/casa-mosquitto
- MQTT wiki: https://github.com/mqtt/mqtt.github.io/wiki
- Mosquitto project: https://github.com/eclipse/mosquitto
- MQTT.fx MQTT client: http://mqttfx.org/
- Arduino MQTT library: https://learn.adafruit.com/mqtt-adafruit-io-and-you/arduino-plus-library-setup

## Inspired by
- http://www.steves-internet-guide.com/mosquitto-tls/
- https://github.com/thelebster/example-mosquitto-simple-auth-docker

## License
[GPL-2.0+](LICENSE) © 2019 [Roel Schut](https://roelschut.nl)
