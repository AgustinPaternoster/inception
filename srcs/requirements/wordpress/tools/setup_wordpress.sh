#!/bin/bash
set -e

db_password=$(cat $DB_USER_PASSWORD)
admin_pass=$(cat $WP_ADMIN_PASS)
user_pass=$(cat $WP_USER_PASS)

echo "Esperando a que la base de datos esté lista..."
until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$db_password" "$DB_NAME" &>/dev/null; do
  sleep 2
done
echo "Base de datos disponible."

if [ ! -f wp-config.php ]; then
  echo "Instalando WordPress..."
  wp core download --allow-root

  wp config create --allow-root \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$db_password" \
    --dbhost="$DB_HOST" \
    --path='/var/www/html'

  wp core install --allow-root \
    --url="https://${DOMAIN_NAME}" \
    --title="Inception Project" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$admin_pass" \
    --admin_email="$WP_ADMIN_EMAIL"

  wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --role=author \
    --user_pass="$user_pass" \
    --allow-root
fi

chown -R www-data:www-data /var/www/html

exec  php-fpm8.2 -F

