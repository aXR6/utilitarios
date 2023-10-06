#!/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root" 
   exit 1
fi

echo "Atualizando a lista de pacotes..."
apt update

echo "Instalando o UFW (firewall)..."
apt install -y ufw

echo "Habilitando o UFW..."
ufw enable

echo "Bloqueando todo o tráfego de entrada e permitindo o tráfego de saída..."
ufw default deny incoming
ufw default allow outgoing

echo "Instalando e configurando o Uncomplicated Web Browser (navegador seguro)..."
apt install -y epiphany-browser
# O Epiphany é um navegador que segue o modelo de design da GNOME, oferecendo uma experiência de navegação simplificada e segura.

echo "Instalando extensões do navegador para maior segurança..."
# Por enquanto, estamos assumindo que o Firefox está instalado. Adicione scripts de instalação/ativação de extensões conforme sua necessidade.

echo "Instalando o OpenVPN..."
apt install -y openvpn
# Configure o OpenVPN com sua VPN de escolha após a instalação

echo "Navegação segura configurada com sucesso!"