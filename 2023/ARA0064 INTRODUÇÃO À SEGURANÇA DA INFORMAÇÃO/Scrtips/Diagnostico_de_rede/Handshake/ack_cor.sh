#!/bin/bash

# Função para imprimir com cor
print_with_color() {
    local color_code=$1
    shift
    echo -e "\033[${color_code}m$@\033[0m"
}

# Caminho para o arquivo de captura do Wireshark
capture_file="teste.pcapng"

# Verifica se o arquivo de captura existe
if [ ! -f "$capture_file" ]; then
    echo "Arquivo de captura '$capture_file' não encontrado."
    exit 1
fi

# Executa o comando tshark para analisar o tráfego de rede
tshark -r "$capture_file" -T fields -e frame.number -e frame.time -e tcp.flags.ack -e tcp.flags.fin -e tcp.flags.syn -e tcp.flags.reset -e tcp.flags.push -e tcp.srcport -e tcp.dstport -e ip.src -e ip.dst -e frame.len |
while IFS=$'\t' read -r frame_number frame_time ack fin syn reset push urgent src_port dst_port src_ip dst_ip frame_len; do
    if [[ $ack == "1" ]]; then
        print_with_color 33 "Frame Number: $frame_number"
        print_with_color 33 "Frame Time: $frame_time"
        print_with_color 33 "ACK: $ack"
    else
        echo "Frame Number: $frame_number"
        echo "Frame Time: $frame_time"
        echo "ACK: $ack"
    fi

    echo "Source Port: $src_port"
    echo "Destination Port: $dst_port"
    echo "Source IP: $src_ip"
    echo "Destination IP: $dst_ip"
    echo "Frame Length: $frame_len"
    echo ""
done
