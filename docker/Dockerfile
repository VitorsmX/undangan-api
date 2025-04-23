FROM php:8.2-fpm

# Dependências necessárias
RUN apt-get update --fix-missing && apt-get install -y \
    nginx supervisor zip unzip libonig-dev libicu-dev libzip-dev libpq-dev \
    build-essential libssl-dev zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalação de extensões PHP
RUN docker-php-ext-install pdo zip pdo_pgsql pgsql opcache

# Instala o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia arquivos do projeto
WORKDIR /var/www
COPY . .

# Instala as dependências PHP
RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction

# Copia os arquivos de configuração do nginx e supervisor
COPY docker/nginx/default.conf /etc/nginx/sites-available/default
COPY docker/supervisord.conf /etc/supervisord.conf

# Expõe porta HTTP padrão
EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
