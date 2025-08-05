#!/bin/sh

# exit if any command fail
set -e

# initialize DB only if not yet, hides output to keep logs clean > /dev/null
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

    echo "Starting temporary MariaDB server..."
    mysqld --user=mysql --skip-networking &
    pid="$!"

    # Give it a few seconds to start
    sleep 5

    echo "Running init.sql..."
    mysql -u root < /docker-entrypoint-initdb.d/init.sql

    echo "Stopping temporary MariaDB server..."
    kill "$pid"
    wait "$pid"
fi

#  --bootstrap one time initalization, skip client connections


echo "Starting MariaDB..."

# replace shell process (PID 1) with mysqld, run non-admin
exec mysqld --user=mysql
