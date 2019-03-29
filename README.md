Mosquitto MQTT broker
=====================

This Docker image adds a default password and creates CA and server certificates so the MQTT broker can be accessed 
over SSL/TLS. It also adds some default configs for websockets and logging.

### Ports
| Port | Connection |
|------|------------|
|```1883```| Default
|```8883```| SSL/TLS
|```9001```| Websocket

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
`mosquitto_certs -o 192.168.0.254` Creates new certificates for the broker with common name the given ip address.
`mosquitto_certs mqtt.local.lan` Creates certificates when they do not already exist.


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
