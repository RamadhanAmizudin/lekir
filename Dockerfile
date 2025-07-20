FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev \
    zip \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-enable mysqli pdo_mysql

RUN a2enmod rewrite
COPY --from=composer /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html
COPY . /var/www/html/

RUN composer install --no-interaction --no-scripts --no-plugins || true
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
