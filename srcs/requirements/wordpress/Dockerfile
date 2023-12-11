# Use Alpine as the base image
FROM alpine:3.13

# Install PHP and php-fpm
RUN		apk update && apk upgrade && \
		apk add --no-cache \
		wget \
		tar \
		mariadb-client \
		redis \
		php7 \
		php7-fpm \
		php7-bcmath \
		php7-bz2 \
		php7-calendar \
		php7-ctype \
		php7-curl \
		php7-dom \
		php7-exif \
		php7-fileinfo \
		php7-gd \
		php7-gmagick \
		php7-gmp \
		php7-iconv \
		php7-imap \
		php7-intl \
		php7-json \
		php7-mbstring \
		php7-mcrypt \
		php7-memcache \
		php7-mysqli \
		php7-mysqlnd \
		php7-openssl \
		php7-pcntl \
		php7-pdo \
		php7-pdo_mysql \
		php7-pdo_pgsql \
		php7-pdo_sqlite \
		php7-pgsql \
		php7-phar \
		php7-posix \
		php7-session \
		php7-shmop \
		php7-simplexml \
		php7-soap \
		php7-sockets \
		php7-sodium \
		php7-sqlite3 \
		php7-sysvsem \
		php7-sysvshm \
		php7-tokenizer \
		php7-xml \
		php7-xmlreader \
		php7-xmlwriter \
		php7-xsl \
		php7-zip \
		php7-zlib

RUN		wget https://it.wordpress.org/latest-it_IT.zip
RUN		unzip latest-it_IT.zip
RUN		mkdir -p /var/www/html
RUN		mv wordpress/* /var/www/html
#used to run as a non-root user.
#this can improve security by limiting the privileges of the web server 
#and reducing the risk of unauthorized access.
RUN		adduser -S nginx && addgroup -S nginx

#coping configuration files
COPY	conf/php-fpm.conf /etc/php7/php-fmp.conf
COPY	conf/www.conf	/etc/php7/php-fpm.d/www.conf



#downloads wp-cli from github and save it as a .phar file
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

#sets the working directory
WORKDIR	/var/www/html/wordpress

#copy the configuration script in tmp folder
COPY    script/configure.sh /tmp/configure.sh

#execute the configuration script just copied
ENTRYPOINT	[ "sh", "/tmp/configure.sh" ]