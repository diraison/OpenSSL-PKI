#!/bin/bash

. $(dirname $0)/../../rootca.config

echo "email address ? "
read EMAIL_ADDRESS

openssl pkcs12  -passin file:$CA_BASEDIR/private/${EMAIL_ADDRESS}.pwd \
		-inkey $CA_BASEDIR/private/${EMAIL_ADDRESS}.key \
		-in $CA_BASEDIR/certs/${EMAIL_ADDRESS}.crt \
		-certfile $CA_BASEDIR/ca.crt \
		-out $CA_BASEDIR/${EMAIL_ADDRESS}.p12 \
		-export
