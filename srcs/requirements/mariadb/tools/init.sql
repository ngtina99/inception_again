--TODO ${MYSQL_DATABASE} instead of wordpress

-- WordPress database if not exists
CREATE DATABASE IF NOT EXISTS wordpress;

-- (WordPress) user (non-admin)
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%';

-- second user (admin but name must not contain "admin")
CREATE USER IF NOT EXISTS 'superuser'@'%' IDENTIFIED BY 'somepass';
GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%';