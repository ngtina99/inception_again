#!/bin/sh
set -e

# Wait for MariaDB to be ready
echo "[WordPress] Waiting for MariaDB..."
until mysqladmin ping -h"$MYSQL_HOST" --silent; do
    sleep 1
done
echo "[WordPress] MariaDB is up."

# If WordPress is not already installed
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "[WordPress] Downloading WordPress..."
    wp core download --path=/var/www/html --allow-root

    echo "[WordPress] Creating wp-config.php..."
    wp config create \
        --path=/var/www/html \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOST \
        --allow-root

    echo "[WordPress] Installing WordPress..."
    wp core install \
        --path=/var/www/html \
        --url=https://$DOMAIN_NAME \
        --title="Inception42" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    echo "[WordPress] Creating regular user..."
    wp user create $WP_USER $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=editor \
        --allow-root
fi

echo "[WordPress] Starting php-fpm..."
exec php-fpm81 -F