#!/bin/bash

# Faixa de rede (exemplo: 192.168.0.0/24)
network_range="192.168.0.0/24"

# Nome do arquivo de saída
output_file="ips_online.txt"

# Executa o nmap para identificar os IPs online na rede
nmap_output=$(nmap -sn $network_range)

# Extrai os IPs online do resultado do nmap
online_ips=$(echo "$nmap_output" | awk '/^Nmap scan report/{print $NF}')

# Identifica a faixa de IP
ip_range=$(echo "$network_range" | awk -F '/' '{print $1}')

# Salva a faixa de rede, a faixa de IP e os IPs online no arquivo de saída
echo "Faixa de rede: $network_range" > "$output_file"
echo "Faixa de IP: $ip_range" >> "$output_file"
echo "IPs online:" >> "$output_file"
echo "$online_ips" >> "$output_file"

echo "Resultados salvos em $output_file"