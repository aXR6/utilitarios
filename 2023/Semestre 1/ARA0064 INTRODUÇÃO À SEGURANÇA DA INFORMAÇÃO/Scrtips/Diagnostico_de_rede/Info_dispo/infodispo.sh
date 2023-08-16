#!/bin/bash

# Endereço IP ou intervalo de endereços IP a serem escaneados
target="192.168.0.0/24"

# Arquivo de saída para os resultados
output_file="scan_results.txt"

# Executa o comando Nmap para realizar o scan de rede
nmap -sV -O -oN "$output_file" "$target"

# Exibe os resultados
cat "$output_file"
