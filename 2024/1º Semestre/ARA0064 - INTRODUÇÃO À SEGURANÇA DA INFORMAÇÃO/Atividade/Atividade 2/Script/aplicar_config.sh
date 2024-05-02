#!/bin/bash

# Função para aplicar configurações de segurança no Apache
configure_apache() {
    echo "Configurando segurança para Apache..."
    sudo apt-get update && sudo apt-get upgrade -y
    sudo a2enmod headers
    sudo a2enmod ssl

    # Configurações de Segurança
    sudo sed -i 's/ServerTokens OS/ServerTokens Prod/' /etc/apache2/conf-available/security.conf
    sudo sed -i 's/ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf

    # SSL/TLS Configurações
    sudo sed -i '/<\/VirtualHost>/i \\tRedirect permanent / https://seusite.com/' /etc/apache2/sites-available/000-default.conf

    # Configuração de Logs
    echo "LogFormat \"%v:%p %h %l %u %t \\\"%r\\\" %>s %O \\\"%{Referer}i\\\" \\\"%{User-Agent}i\\\"" combined_vhost" | sudo tee -a /etc/apache2/apache2.conf
    echo "CustomLog /var/log/apache2/access.log combined_vhost" | sudo tee -a /etc/apache2/apache2.conf

    # Rotação de Logs com logrotate
    echo "/var/log/apache2/*.log {
        daily
        missingok
        rotate 14
        compress
        delaycompress
        notifempty
        create 640 root adm
        sharedscripts
        postrotate
            if /etc/init.d/apache2 status > /dev/null ; then \
                /etc/init.d/apache2 reload > /dev/null; \
            fi;
        endscript
    }" | sudo tee /etc/logrotate.d/apache2

    echo "Apache configurado com sucesso."
}

# Função para aplicar configurações de segurança no Nginx
configure_nginx() {
    echo "Configurando segurança para Nginx..."
    sudo apt-get update && sudo apt-get upgrade -y

    # Configurações de segurança básicas
    sudo sed -i '/http {/a \\tserver_tokens off;' /etc/nginx/nginx.conf
    sudo sed -i '/server {/a \\tadd_header X-Frame-Options "SAMEORIGIN";' /etc/nginx/sites-available/default

    # SSL/TLS Configurações
    sudo sed -i '/server {/a \\treturn 301 https://$server_name$request_uri;' /etc/nginx/sites-available/default

    # Configuração de Logs
    sudo sed -i '/http {/a \\taccess_log /var/log/nginx/access.log combined;' /etc/nginx/nginx.conf
    sudo sed -i '/http {/a \\terror_log /var/log/nginx/error.log warn;' /etc/nginx/nginx.conf

    # Rotação de Logs com logrotate
    echo "/var/log/nginx/*.log {
        daily
        missingok
        rotate 14
        compress
        delaycompress
        notifempty
        create 0644 nginx nginx
        sharedscripts
        postrotate
            [ -f /var/run/nginx.pid ] && kill -USR1 $(cat /var/run/nginx.pid)
        endscript
    }" | sudo tee /etc/logrotate.d/nginx

    echo "Nginx configurado com sucesso."
}

# Detectar se Apache ou Nginx estão instalados
if [ -x "$(command -v apache2)" ]; then
    echo "Apache está instalado."
    configure_apache
elif [ -x "$(command -v nginx)" ]; then
    echo "Nginx está instalado."
    configure_nginx
else
    echo "Nenhum servidor web Apache ou Nginx detectado."
fi
