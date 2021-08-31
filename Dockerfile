FROM php:8-apache

ENV COMPOSER_MEMORY_LIMIT=-1
ENV TZ=Australia/Brisbane

#
# Dependencies for PHP and PHP extensions
#
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  git \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libonig-dev \
  libpng-dev \
  libssl-dev \
  libxml2-dev \
  libzip-dev \
  unzip \
  zip \
  zlib1g-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
  bcmath \
  exif \
  gd \
  mbstring \
  mysqli \
  pcntl \
  pdo_mysql \
  pdo \
  zip

RUN pecl install ast-1.0.14
RUN docker-php-ext-enable ast

#
# Install Xdebug
#
RUN pecl install xdebug \
  && docker-php-ext-enable xdebug \
  && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.discover_client_host=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

#
# Install Composer (based off code from: https://getcomposer.org/download/)
#
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --version=2.1.3 --filename=composer --install-dir=/usr/local/bin
RUN php -r "unlink('composer-setup.php');"

#
# Install node and npm
#
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

#
# Enable Apache mod_rewrite
#
RUN a2enmod rewrite

#
# Copy in the php.ini file
#
COPY php.ini "$PHP_INI_DIR/php.ini"

#
# Default workdir
#
WORKDIR /var/www/html
