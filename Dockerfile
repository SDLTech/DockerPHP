FROM php:7.4-apache

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

RUN docker-php-ext-configure gd --with-freetype

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

#
# Install Composer (based off code from: https://getcomposer.org/download/)
#
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --version=1.10.13 --filename=composer --install-dir=/usr/local/bin
RUN php -r "unlink('composer-setup.php');"

#
# Install node and npm
#
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
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
