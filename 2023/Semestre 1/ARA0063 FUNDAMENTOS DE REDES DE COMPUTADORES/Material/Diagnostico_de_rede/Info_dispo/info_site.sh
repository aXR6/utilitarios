#!/bin/bash

# Endereço IP ou hostname do alvo a ser verificado
target="192.168.0.228"

# Nome do arquivo CSV de saída
output_file="protecao_rede.csv"

# Verifica se o alvo responde a ping
ping -c 1 "$target" >/dev/null 2>&1
if [ $? -eq 0 ]; then
  ping_status="O alvo responde a ping"
else
  ping_status="O alvo não responde a ping"
fi

# Verifica se o alvo possui firewall ativo
nc -z -w 1 "$target" 22 >/dev/null 2>&1
if [ $? -eq 0 ]; then
  firewall_status="O alvo possui firewall ativo"
else
  firewall_status="O alvo não possui firewall ativo"
fi

# Verifica se o alvo tem portas abertas
open_ports=$(nmap -p- "$target" | grep ^[0-9] | cut -d '/' -f 1)
if [ -n "$open_ports" ]; then
  open_ports_status="O alvo possui as seguintes portas abertas: $open_ports"
else
  open_ports_status="O alvo não possui portas abertas"
fi

# Verifica se o alvo possui SSL/TLS habilitado
ssl_check=$(openssl s_client -connect "$target":443 -servername "$target" </dev/null 2>/dev/null | openssl x509 -noout -issuer)
if [ -n "$ssl_check" ]; then
  ssl_status="O alvo possui SSL/TLS habilitado"
else
  ssl_status="O alvo não possui SSL/TLS habilitado"
fi

# Escreve as informações no arquivo CSV
echo "Alvo,Status" > "$output_file"
echo "Ping: $ping_status" >> "$output_file"
echo "Firewall: $firewall_status" >> "$output_file"
echo "Portas abertas: $open_ports_status" >> "$output_file"
echo "SSL/TLS: $ssl_status" >> "$output_file"

echo "As informações foram salvas em: $output_file"