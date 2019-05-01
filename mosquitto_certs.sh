#!/bin/sh
set -e

if [ -z "${1}" ]
then
  echo "Common Name not defined"
  exit 1
fi

# default vars/options
CERTS_DIR=/mosquitto/config/certs
OPT_OVERWRITE=false

# extract options
while getopts ":o:" opt
do
  case ${opt} in
    o) OPT_OVERWRITE=true
    ;;
  esac
done

# check if we should overwrite current certificates or
# have an empty dir and need to create them
if [ ! -d ${CERTS_DIR} ]
then
    mkdir ${CERTS_DIR}
elif [ ${OPT_OVERWRITE} = true ]
then
    rm -rf \
        ${CERTS_DIR}/ca.* \
        ${CERTS_DIR}/server.*
else
    # we have certificates and should not overwrite them
    exit
fi

openssl genrsa -out ${CERTS_DIR}/ca.key 2048

openssl req \
    -new \
    -x509 \
    -subj "/CN=${1}" \
    -days 1460 \
    -key ${CERTS_DIR}/ca.key \
    -out ${CERTS_DIR}/ca.crt

openssl genrsa -out ${CERTS_DIR}/server.key 2048
openssl req \
    -new \
    -subj "/CN=${1}-server" \
    -key ${CERTS_DIR}/server.key \
    -out ${CERTS_DIR}/server.csr

openssl x509 \
    -req \
    -CAcreateserial \
    -days 2920 \
    -CA ${CERTS_DIR}/ca.crt \
    -CAkey ${CERTS_DIR}/ca.key \
    -in ${CERTS_DIR}/server.csr \
    -out ${CERTS_DIR}/server.crt

openssl verify -CAfile \
    ${CERTS_DIR}/ca.crt \
    ${CERTS_DIR}/server.crt
