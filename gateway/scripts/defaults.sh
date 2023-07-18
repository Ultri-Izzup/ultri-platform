#!/bin/sh
#
# RUN FROM PROJECT ROOT.
# sh gateway/scripts/defaults.sh

openssl req -config ./gateway/certs/service.default.conf -newkey rsa:4096 -nodes -keyout ./gateway/certs/default-service.key -x509 -days 365 -out ./gateway/certs/default-service.pem

openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out ./gateway/config/account.key