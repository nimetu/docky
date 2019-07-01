#
#FROM php:7.3-fpm-alpine
FROM php:7.3-fpm-stretch

# use development ini as default (this is kept inside container)
RUN cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

RUN apt-get update && \
	apt-get install -y libpng-dev libpng-tools libpng16-16 zlib1g-dev && \
	docker-php-ext-install pdo pdo_mysql mysqli gd && \
	apt-get remove -y --purge libpng-dev zlib1g-dev && \
	apt-get clean -y

RUN useradd -ms /bin/bash ryzom && \
	echo "ryzom:ryzom" | chpasswd && \
	adduser ryzom sudo

USER ryzom
WORKDIR /var/www

