FROM php:8-fpm-alpine

RUN apk add --no-cache --update libxslt-dev
RUN  docker-php-ext-install xsl \
  && docker-php-ext-configure xsl --with-xsl \
  && docker-php-ext-enable xsl

WORKDIR /var/www/html
