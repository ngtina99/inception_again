#!/bin/sh

#nginx cert if there is no fild, then run certification generation script
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
	/mkcert.sh
fi

#start webserv, global, in the foreground (off) keeps the container running 
nginx -g "daemon off;"