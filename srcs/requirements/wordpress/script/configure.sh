#!/bin/sh

# wait for mysql
while ! mariadb -h$MYSQL_HOSTNAME -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then
     
    mv /tmp/html/* /var/www/html
 
    echo "ciao2"
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    echo "ciao3"
    wp core install --url=$DOMAIN_NAME --title=enoviellsite --admin_user=$WP_USER_ADMIN --admin_password=$WP_PWD_ADMIN --admin_email=$WP_EMAIL_ADMIN --skip-email --allow-root
    echo "ciao4"
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$PASSWORD_WP --allow-root
    echo "ciao5"
    wp theme install bizboost --activate --allow-root
    echo "ciao6"
fi

/usr/sbin/php-fpm7 -F -R
