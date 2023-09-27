#!/bin/bash

# Atualizar repositórios e sistema
sudo dnf update -y

# Instalar Apache (httpd)
sudo dnf install -y httpd sysstat

# Instalar PHP8 e extensões necessárias
sudo dnf install -y php php-mysqlnd

# Instalar MySQL (MariaDB) Server
sudo dnf install -y mariadb-server

# Instalar Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# Iniciar e habilitar Docker
sudo systemctl start docker
sudo systemctl enable docker

# Instalar Git
sudo dnf install -y git

# Instalar tcpdump
sudo dnf install -y tcpdump

echo "Instalação concluída!"
