#!/bin/bash

echo "Ce script etablit la configuration de base de la CA.
Il enregistre les informations Ville, Organisation et Nom de la CA dans le fichier rootca.config
Faites CTRL+C pour abandonner"

cd $(dirname $0)
CA_BASEDIR="$PWD"

echo -n "Ville ? "
read LOCALITY_NAME

echo -n "Organisation ? "
read ORGANIZATION_NAME

echo -n "Nom de la CA ? "
read COMMON_NAME

cat <<EOF >rootca.config
CA_BASEDIR="$CA_BASEDIR"
LOCALITY_NAME="$LOCALITY_NAME"
ORGANIZATION_NAME="$ORGANIZATION_NAME"
COMMON_NAME="$COMMON_NAME"
export CA_BASEDIR LOCALITY_NAME ORGANIZATION_NAME COMMON_NAME
EOF
