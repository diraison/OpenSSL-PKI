#!/bin/bash

if [ $# != 1 ]
then
	echo "usage: $0 certfile"
	exit
fi

CERTIFICATE=$1
if [ ! -f "$CERTIFICATE" ]
then
	echo "$CERTIFICATE is not a valid file"
	exit 1
fi

. $(dirname $0)/../../rootca.config

# check given cert file
openssl ca -config $CA_BASEDIR/conf/ca_sig_crl.cnf \
	   -passin file:$CA_BASEDIR/private/ca.pwd \
	   -revoke ${CERTIFICATE}

