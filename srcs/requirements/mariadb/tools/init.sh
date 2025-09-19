#!/bin/sh

mkdir -p /var/lib/mysql /run/mysqld
chown mysql:mysql /var/lib/mysql /run/mysqld
gosu mysql mysqld &
MYSQL_PID=$!

until mysqladmin ping --silent; do
	echo "Esperando a que MariaDB arranque..."
	sleep 1
done

mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';
CREATE USER IF NOT EXISTS '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO  '$DB_ADMIN'@'%';
GRANT ALL PRIVILEGES ON  \`$DB_NAME\`.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF
kill -TERM $MYSQL_PID
wait $MYSQL_PID
exec gosu mysql mysqld



