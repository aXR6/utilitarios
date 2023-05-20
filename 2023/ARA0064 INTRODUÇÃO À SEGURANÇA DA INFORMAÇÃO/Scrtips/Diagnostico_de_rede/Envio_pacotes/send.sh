#!/bin/bash

# Arquivo de entrada contendo os endereços IP
input_file="ips_online.txt"

# Arquivo de saída para os resultados
output_file="resultados.txt"

# Quantidade de pacotes a serem enviados
packet_count=10

# Verifica se o arquivo de entrada existe
if [ ! -f "$input_file" ]; then
    echo "Arquivo de entrada '$input_file' não encontrado."
    exit 1
fi

# Loop para ler cada linha do arquivo de entrada
while IFS= read -r destination_ip
do
    echo "Enviando pacotes para $destination_ip..."
    
    # Loop para enviar os pacotes
    for ((i=1; i<=$packet_count; i++))
    do
        # Envia um pacote ICMP (ping) para o endereço IP de destino
        ping -c 1 $destination_ip > /dev/null

        # Verifica o código de saída do comando ping
        if [ $? -eq 0 ]; then
            echo "Pacote $i enviado para $destination_ip - Sucesso" >> "$output_file"
        else
            echo "Pacote $i enviado para $destination_ip - Falha" >> "$output_file"
        fi
    done
    
    echo "Pacotes enviados para $destination_ip."
    echo
done < "$input_file"

echo "Processo concluído. Resultados salvos em '$output_file'."