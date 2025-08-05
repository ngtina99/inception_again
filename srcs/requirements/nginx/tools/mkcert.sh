#!/bin/sh

# run in lightweight shell 

# set variables, ssl for nginx.key (private key) and nginx.crt (certification file)
SSL_DIR=/etc/nginx/ssl

# if it is not set use localhost
DOMAIN=${DOMAIN_NAME: -localhost}

mkdir -p $SSL_DIR

# Self-signed certification request, no DES encryption, not needed password to start, 1 year validity, RSA standard 2048 bits long, path
openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048
	-keyout $SSL_DIR/nginx.key \
	-out $SSL_DIR/nginx.crt \
    -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=Inception/CN=$DOMAIN"

#OU (Organizational Unit = depratment, CN Common Name/Domain Name)