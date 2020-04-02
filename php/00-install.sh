#!/bin/sh

apk add automake  libtool pkgconfig bzip2 file re2c freetds freetype icu libintl libldap libjpeg libmcrypt libpng libpq libwebp libzip imagemagick

TMP="autoconf bzip2-dev freetds-dev freetype-dev g++ gcc gettext-dev icu-dev jpeg-dev libmcrypt-dev libpng-dev libwebp-dev libxml2-dev libzip-dev make openldap-dev postgresql-dev zlib-dev libjpeg-turbo-dev libxslt-dev gmp-dev imagemagick-dev"
apk add $TMP

# Configure extensions
docker-php-ext-configure gd --with-jpeg-dir=usr/ --with-freetype-dir=usr/ --with-webp-dir=usr/
docker-php-ext-configure ldap --with-libdir=lib/
docker-php-ext-configure pdo_dblib --with-libdir=lib/

docker-php-ext-install \
    bz2 \
    exif \
    gd \
    gettext \
    intl \
    ldap \
    pdo_dblib \
    pdo_mysql \
    xmlrpc \
    soap \
    bcmath \
    pcntl \
    zip

# Download trusted certs
apk add --update ca-certificates && \
rm -rf /var/cache/apk/* /tmp/*

# Install composer
cd /tmp && php -r "readfile('https://getcomposer.org/installer');" | php && \
	mv composer.phar /usr/bin/composer && \
	chmod +x /usr/bin/composer

pecl install imagick
docker-php-ext-enable imagick

apk del $TMP

# Install PHPUnit
curl -sSL -o /usr/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/bin/phpunit
