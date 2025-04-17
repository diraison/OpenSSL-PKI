#!/bin/bash

. $(dirname $0)/../rootca.config

# sign certificat request
openssl ca -config $CA_BASEDIR/conf/ca_sig_crl.cnf \
	   -passin file:$CA_BASEDIR/private/ca.pwd \
	   -out $CA_BASEDIR/crl/crl.pem \
	   -notext \
	   -gencrl
