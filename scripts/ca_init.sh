#!/bin/bash

. $(dirname $0)/../rootca.config

# create password for key encryption
umask 0027
[ -d "$CA_BASEDIR/private" ] || mkdir "$CA_BASEDIR/private"
if [ ! -s "$CA_BASEDIR/private/ca.pwd" ];then
	dd if=/dev/urandom bs=16 count=128|base64|tr -d "018=/+\n"|cut -b -43 >"$CA_BASEDIR/private/ca.pwd"
fi

# generates rootca key and self signed authority certificate
umask 0027
openssl genrsa -aes256 \
	       -passout file:$CA_BASEDIR/private/ca.pwd \
	       -out $CA_BASEDIR/private/ca.key \
	       4096
umask 0022
openssl req -config $CA_BASEDIR/conf/ca_init.cnf \
	    -passin file:$CA_BASEDIR/private/ca.pwd \
	    -key $CA_BASEDIR/private/ca.key \
	    -out $CA_BASEDIR/ca.crt \
	    -days 7300 \
	    -x509 \
	    -new

# show 
#openssl x509 -in $CA_BASEDIR/rootca.crt -text -noout

# generate hash access and directories
umask 0022
cd $CA_BASEDIR
[ -d "$CA_BASEDIR/crl" ] || mkdir "$CA_BASEDIR/crl"
[ -d "$CA_BASEDIR/certs" ] || mkdir "$CA_BASEDIR/certs"
[ -d "$CA_BASEDIR/newcerts" ] || mkdir "$CA_BASEDIR/newcerts"
[ -d "$CA_BASEDIR/csr" ] || mkdir "$CA_BASEDIR/csr"
HASH=`openssl x509 -hash -in ca.crt -noout`
ln -s ca.crt ${HASH}.0
ln -s crl/crl.pem ${HASH}.r0
touch "$CA_BASEDIR/index.txt"	# ca database file
echo "01" >"$CA_BASEDIR/serial"	# debut de la numerotation des certificats
