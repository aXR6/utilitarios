#!/bin/bash

# Define o domínio de busca, máscara de rede, gateway e servidores DNS
searchdomain="tsc.example.com"
NETMASK="255.255.255.0"
GATEWAY="192.168.1.1"
DNS1="8.8.8.8"
DNS2="8.8.4.4"

# Determina a interface de rede principal
PRIMARY_INTERFACE=$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")

# Determina se o script está sendo executado no NS1 ou no NS2 através do hostname
HOSTNAME=$(hostname)

# Configura a URL do repositório e o endereço IP conforme o servidor
if [[ $HOSTNAME == "NS1" ]]; then
    IPADDR="192.168.0.200"
    REPO_URL="https://github.com/aXR6/utilitarios.git"
    REPO_SUBDIR="utilitarios/2022/ano_2022/Srv_DNS/Pasta_ETC-BIND_NS1"
elif [[ $HOSTNAME == "NS2" ]]; then
    IPADDR="192.168.0.199"
    REPO_URL="https://github.com/aXR6/utilitarios.git"
    REPO_SUBDIR="utilitarios/2022/ano_2022/Srv_DNS/Pasta_ETC-BIND_NS2"
else
    echo "Este script deve ser executado em NS1 ou NS2."
    exit 1
fi

# Configura o arquivo /etc/network/interfaces
cat <<EOF > /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto $PRIMARY_INTERFACE
iface $PRIMARY_INTERFACE inet static
    address $IPADDR
    netmask $NETMASK
    gateway $GATEWAY
    dns-search $searchdomain
    dns-nameservers $DNS1 $DNS2
EOF

# Reinicia a interface de rede para aplicar as configurações
ifdown $PRIMARY_INTERFACE && ifup $PRIMARY_INTERFACE

# Clona o repositório especificado
TEMP_DIR=$(mktemp -d)
git clone $REPO_URL $TEMP_DIR

# Faz um backup da pasta /etc/bind, apaga seu conteúdo e copia os novos arquivos
BIND_DIR="/etc/bind"
BACKUP_DIR="${BIND_DIR}_backup_$(date +%Y%m%d%H%M%S)"
mv $BIND_DIR $BACKUP_DIR
mkdir $BIND_DIR
cp -r $TEMP_DIR/$REPO_SUBDIR/* $BIND_DIR

# Limpeza
rm -rf $TEMP_DIR

echo "Configuração de rede aplicada e arquivos BIND atualizados com sucesso."