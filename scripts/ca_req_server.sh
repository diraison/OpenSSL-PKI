#!/bin/bash

. $(dirname $0)/../rootca.config

echo "nom du serveur [commonName] (ex: www.exemple.local) ? "
read SERVER_CN
echo "autres noms [subjectAltName] (ex: DNS:exemple.local,IP:127.0.0.1) ? "
read SERVER_SAN
export SERVER_CN SERVER_SAN

NAME=$SERVER_CN

if [ "$SERVER_CN" == "" -o "$SERVER_SAN" == "" ]
then
	echo "SERVER_CN=$SERVER_CN"
	echo "SERVER_SAN=$SERVER_SAN"
	exit 1
fi

# generate rootca key and self signed authority certificat
openssl genrsa -out $CA_BASEDIR/private/${NAME}.key \
	       2048

openssl req -config $CA_BASEDIR/conf/ca_req_server.cnf \
	    -key $CA_BASEDIR/private/${NAME}.key \
	    -out $CA_BASEDIR/csr/${NAME}.csr \
	    -new
