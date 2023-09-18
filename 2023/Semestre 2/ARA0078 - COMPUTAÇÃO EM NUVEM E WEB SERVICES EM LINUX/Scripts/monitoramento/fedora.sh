#!/bin/bash

# Defina a estrutura de diretórios com base na data e hora
DIR="./logs/$(date +'%Y-%m-%d')"
FILE="$DIR/$(date +'%H-%M-%S').log"

# Crie o diretório se não existir
mkdir -p "$DIR"

# Redirecione a saída padrão e erros para o arquivo de log
exec > "$FILE" 2>&1

echo "==== INFORMAÇÕES DO SISTEMA ===="

# Informações sobre hardware
echo "--- Informações do Hardware ---"
lscpu
echo
lshw -short | grep -E "system|processor|memory|disk|network"
echo

# Uso de memória
echo "--- Uso de Memória ---"
free -h
echo

# Uso de rede
echo "--- Uso de Rede ---"
ifconfig | grep -E "inet|RX bytes"
echo

# Uso de I/O do disco
echo "--- Uso de I/O do Disco ---"
iostat
echo

# Quantidade de processos em uso
echo "--- Processos em Execução ---"
echo "Total: $(ps aux | grep -v "grep" | wc -l)"
echo

# Quantidade de processos parados
echo "--- Processos Parados ---"
echo "Total: $(ps aux | grep -v "grep" | grep "T" | wc -l)"
echo

# Quantidade de softwares instalados
echo "--- Softwares Instalados ---"
echo "Total: $(dnf list installed | wc -l)"
echo

# Carga Média do Sistema e Uptime
echo "--- Carga Média e Uptime ---"
uptime
echo

# Informações sobre aquecimento
echo "--- Temperatura do Hardware ---"
sensors
echo

# Identificação da máquina na rede
echo "--- Identificação na Rede ---"
echo "Hostname: $(hostname)"
echo "Endereço IP: $(hostname -I)"
echo

echo "==============================="