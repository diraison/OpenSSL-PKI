#!/bin/bash

. $(dirname $0)/../../rootca.config

echo -n "Organizational Unit Name ? "
read ORGANIZATIONAL_UNIT_NAME
echo -n "User Name ? "
read USER_NAME
echo -n "email address ? "
read EMAIL_ADDRESS
echo -n "password ? "
read PASSWORD

export ORGANIZATIONAL_UNIT_NAME USER_NAME EMAIL_ADDRESS

# genrate rootca key and self signed authority certificat
echo -n "$PASSWORD" >"$CA_BASEDIR/private/${EMAIL_ADDRESS}.pwd"

openssl genrsa -aes256 \
               -passout file:$CA_BASEDIR/private/${EMAIL_ADDRESS}.pwd \
	       -out $CA_BASEDIR/private/${EMAIL_ADDRESS}.key \
	       2048

openssl req -config $CA_BASEDIR/conf/ca_req_user.cnf \
            -passin file:$CA_BASEDIR/private/${EMAIL_ADDRESS}.pwd \
	    -key $CA_BASEDIR/private/${EMAIL_ADDRESS}.key \
	    -out $CA_BASEDIR/csr/${EMAIL_ADDRESS}.csr \
	    -new
