FROM alpine:3.18

# base image

#mariadb database server, client includes tools like MySQL which allows command lines to access MariaDB, su-exec fast sudo
RUN apk update && apk add --no-cache mariadb mariadb-client su-exec

# directories
RUN mkdir -p /run/mysqld /var/lib/mysql /docker-entrypoint-initdb.d

# Copy init script
COPY tools/entrypoint.sh /entrypoint.sh
COPY tools/init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod +x /entrypoint.sh

# ownership, -R rercursively through all files
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql /docker-entrypoint-initdb.d

# default port
EXPOSE 3306

# execute the shell script
ENTRYPOINT ["/entrypoint.sh"]

# # switch to mysql user and run mysqld
# USER mysql

# #  run MariaDB in foreground, mysql daemon
# CMD ["mysqld"]

#TODO ? ENTRYPOINT ["/entrypoint.sh"]
