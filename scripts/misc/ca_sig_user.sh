#!/bin/bash

. $(dirname $0)/../../rootca.config

echo "email address ? "
read EMAIL_ADDRESS

# sign certificat request
openssl ca -config $CA_BASEDIR/conf/ca_sig_user.cnf \
	   -passin file:$CA_BASEDIR/private/ca.pwd \
	   -in $CA_BASEDIR/csr/${EMAIL_ADDRESS}.csr \
	   -out $CA_BASEDIR/certs/${EMAIL_ADDRESS}.crt \
	   -notext \
	   -batch
