#!/bin/bash

echo ">> Aguardando o banco de dados ficar pronto..."

echo ">> Executando migração"
php /var/www/saya migrasi --gen

echo ">> Iniciando supervisord"
exec /usr/bin/supervisord -c /etc/supervisord.conf
