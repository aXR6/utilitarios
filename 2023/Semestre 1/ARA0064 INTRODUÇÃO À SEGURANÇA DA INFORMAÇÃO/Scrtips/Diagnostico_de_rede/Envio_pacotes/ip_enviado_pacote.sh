#!/bin/bash

# Interface de rede a ser monitorada
network_interface="enp4s0"

# Nome do arquivo de saída
output_file="ips_enviado_pacotes.txt"

# Obtém a faixa de rede e a faixa de IP
network=$(ip -o -f inet addr show $network_interface | awk '{print $4}')
network_range=$(echo $network | cut -d'/' -f2)
ip_range=$(ipcalc -n $network | awk -F"=" '{print $2}')

# Exibe a faixa de rede e a faixa de IP
echo "Faixa de Rede: $network"
echo "Faixa de IP: $ip_range"

# Coleta os IPs ativos na rede
active_ips=$(sudo nmap -sn -PR $network | grep 'Nmap scan' | awk '{print $5}')

# Salva os IPs ativos em um arquivo
echo "$active_ips" > $output_file

echo "Lista de IPs ativos salva em $output_file"