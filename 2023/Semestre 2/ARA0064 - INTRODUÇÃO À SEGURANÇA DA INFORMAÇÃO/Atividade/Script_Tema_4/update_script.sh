#!/bin/bash

# Script de Boas Práticas – Atualizações de Software para Debian

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
    echo "Este script deve ser executado como root (ou use sudo)." 1>&2
    exit 1
fi

echo "Atualizando lista de pacotes..."
apt update

echo "Atualizando pacotes instalados..."
apt upgrade -y

echo "Removendo pacotes desnecessários..."
apt autoremove -y

echo "Finalizando atualizações de software..."

# Verificar se é necessário reiniciar
if [ -f /var/run/reboot-required ]; then
    echo "ATENÇÃO: É necessário reiniciar o sistema para concluir algumas atualizações!"
fi

echo "Atualização concluída."