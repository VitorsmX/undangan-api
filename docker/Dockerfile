FROM php:8.2-fpm

# Dependências
RUN apt-get update --fix-missing
RUN apt-get install -y \
    zip unzip \
    libonig-dev libicu-dev \
    libzip-dev libpq-dev \
    build-essential libssl-dev zlib1g-dev \
    postgresql-client \
    supervisor \
    nginx

# Extensões PHP
RUN docker-php-ext-install pdo zip pdo_pgsql pgsql opcache
RUN docker-php-ext-enable pdo zip pdo_pgsql pgsql opcache

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar app
COPY . /var/www
WORKDIR /var/www

# Instalar dependências PHP
RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction

# Copiar configs do supervisord e entrypoint
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh
COPY ca.pem /var/www/ca.pem
RUN chmod 644 /var/www/ca.pem

RUN chmod +x /entrypoint.sh

EXPOSE 80 9000
ENTRYPOINT ["/entrypoint.sh"]
