#!/bin/bash

. $(dirname $0)/../rootca.config

echo -n "identifiant du serveur [commonName] (ex: www.exemple.local) ? "
read SERVER_CN
echo -n "noms de domaine et adresses ip [subjectAltName] (ex: DNS:www.exemple.local,IP:127.0.0.1) ? "
read SERVER_SAN
export SERVER_CN SERVER_SAN

NAME=$SERVER_CN

. $CA_BASEDIR/conf/servers/${NAME}
export SERVER_CN SERVER_SAN

if [ "$SERVER_CN" == "" -o "$SERVER_SAN" == "" ]
then
	echo "SERVER_CN=$SERVER_CN"
	echo "SERVER_SAN=$SERVER_SAN"
	exit 1
fi
			
# sign certificat request
openssl ca -config $CA_BASEDIR/conf/ca_sig_server.cnf \
	   -passin file:$CA_BASEDIR/private/ca.pwd \
	   -in $CA_BASEDIR/csr/${NAME}.csr \
	   -out $CA_BASEDIR/certs/${NAME}.crt \
	   -notext \
	   -batch
