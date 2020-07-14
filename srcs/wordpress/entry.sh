#!/bin/sh
# install wordpress
if [[ ! -f /var/www/localhost/htdocs/index.php ]]; then
	
	curl -SL https://wordpress.org/wordpress-5.4.2.tar.gz \
	| tar -xzC /var/www/localhost/htdocs --strip 1

	tfile=`mktemp`
	cat > $tfile << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER '$USERNAME'@'%' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO '$USERNAME'@'%' WITH GRANT OPTION;
EOF

	mysql -hmysql -uroot -p$MYSQL_ROOT_PASSWORD < $tfile
	rm -f $tfile

	# 이미 설정된 wordpress 웹사이트를 적용시킬 때
	# mysql -hmysql -Dwordpress -uroot -p$MYSQL_ROOT_PASSWORD < /tmp/wordpress.sql

fi

adduser -D -g www www
chown -R www:www /var/www/localhost/htdocs/

# setup openrc
mkdir -p /run/openrc/
touch /run/openrc/softlevel

# config php-fpm
sed -i "s/;listen.owner\s*=\s*nobody/listen.owner = ${PHP_FPM_USER}/g" /etc/php7/php-fpm.d/www.conf
sed -i "s/;listen.group\s*=\s*nobody/listen.group = ${PHP_FPM_GROUP}/g" /etc/php7/php-fpm.d/www.conf
sed -i "s/;listen.mode\s*=\s*0660/listen.mode = ${PHP_FPM_LISTEN_MODE}/g" /etc/php7/php-fpm.d/www.conf
sed -i "s/user\s*=\s*nobody/user = ${PHP_FPM_USER}/g" /etc/php7/php-fpm.d/www.conf
sed -i "s/group\s*=\s*nobody/group = ${PHP_FPM_GROUP}/g" /etc/php7/php-fpm.d/www.conf
sed -i "s/;log_level\s*=\s*notice/log_level = notice/g" /etc/php7/php-fpm.d/www.conf #uncommenting line

sed -i "s/display_errors\s*=\s*Off/display_errors = ${PHP_DISPLAY_ERRORS}/i" /etc/php7/php.ini
sed -i "s/display_startup_errors\s*=\s*Off/display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}/i" /etc/php7/php.ini
sed -i "s/error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = ${PHP_ERROR_REPORTING}/i" /etc/php7/php.ini
sed -i "s/;*memory_limit =.*/memory_limit = ${PHP_MEMORY_LIMIT}/i" /etc/php7/php.ini
sed -i "s/;*upload_max_filesize =.*/upload_max_filesize = ${PHP_MAX_UPLOAD}/i" /etc/php7/php.ini
sed -i "s/;*max_file_uploads =.*/max_file_uploads = ${PHP_MAX_FILE_UPLOAD}/i" /etc/php7/php.ini
sed -i "s/;*post_max_size =.*/post_max_size = ${PHP_MAX_POST}/i" /etc/php7/php.ini
sed -i "s/;*cgi.fix_pathinfo=.*/cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}/i" /etc/php7/php.ini
# config nginx
sed -i "s/user\s*\s*nginx/user www/g" /etc/nginx/nginx.conf

rc-status
rc-service nginx start
rc-service php-fpm7 start
rc-status

nginx -s stop
nginx -g 'daemon off;'