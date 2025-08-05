# Linux based image, small and fast, ideal for Dockerized services
FROM alpine:3.18

# Install packages: download latest, no cache more space, webserver, self-signed TLS (Transport Layer Security) certification
RUN apk update && apk add --no-cache nginx openssl

# Create (parent -p) directories for NGINX (PID for running service), SSL certificate and key, root (serving files)
RUN mkdir -p /run/nginx /etc/nginx/ssl /var/www/html

# Copy NGINX config, cert generation scripts -> from local folder put it into the image
COPY conf/default.conf /etc/nginx/http.d/default.conf
COPY tools/setup.sh /setup.sh
COPY tools/mkcert.sh /mkcert.sh

# Make scripts executable
RUN chmod +x /setup.sh /mkcert.sh

# Expose HTTPS port, listens on port 443 (HTTPS)
EXPOSE 443

# Run  setup script on container start, it calls mkcert.sh to generate the certificate before starting NGiNX
ENTRYPOINT ["/setup.sh"]