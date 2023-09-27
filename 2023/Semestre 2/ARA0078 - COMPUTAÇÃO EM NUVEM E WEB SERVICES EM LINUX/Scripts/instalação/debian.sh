#!/bin/bash

# Atualizar repositórios e sistema
sudo apt update && sudo apt upgrade -y

# Instalar Apache2
sudo apt install -y apache2 sysstat

# Instalar PHP8 e extensões necessárias
sudo apt install -y php8.0 libapache2-mod-php8.0 php8.0-mysql

# Instalar MySQL Server
sudo apt install -y mysql-server

# Instalar Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce

# Instalar Git
sudo apt install -y git

# Instalar tcpdump
sudo apt install -y tcpdump

echo "Instalação concluída!"
