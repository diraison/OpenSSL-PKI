#!/bin/bash

. $(dirname $0)/../rootca.config

# update certificates database
openssl ca -config $CA_BASEDIR/conf/ca_sig_crl.cnf \
	   -passin file:$CA_BASEDIR/private/ca.pwd \
	   -md sha256 \
	   -updatedb

