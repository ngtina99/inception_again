FROM alpine:3.18

# Install PHP-FPM, WordPress deps, WP-CLI, curl for healthcheck
RUN apk update && apk add --no-cache \
    php81 php81-fpm php81-mysqli php81-mbstring php81-json php81-session \
    php81-zlib php81-curl php81-dom php81-exif php81-fileinfo \
    php81-tokenizer php81-xml php81-opcache curl sudo less bash mysql-client

# Create necessary folders
RUN mkdir -p /var/www/html /run/php

# Download WP-CLI
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

# Copy setup script
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/setup.sh"]