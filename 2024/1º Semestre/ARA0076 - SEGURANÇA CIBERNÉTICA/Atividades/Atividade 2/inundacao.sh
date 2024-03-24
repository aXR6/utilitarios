#!/bin/bash

# Diretório temporário para salvar dados
TMP_DIR="/tmp/network_scan"
mkdir -p "$TMP_DIR"
IP_LIST="$TMP_DIR/ip_list.txt"

# Função para instalar as ferramentas
install_tools() {
    sudo apt update
    # Instalar Hping3 e Tcpdump
    sudo apt install -y hping3 tcpdump git

    # Instalar Packet-Flooder
    if ! command -v flood &> /dev/null; then
        install_git
        sudo git clone https://github.com/gamemann/Packet-Flooder.git /opt/packet-flooder
        cd /opt/packet-flooder
        gcc -g src/flood.c -o flood -lpthread
        sudo ln -s /opt/packet-flooder/flood /usr/local/bin/flood
    fi
}

# Função para detectar a interface de rede em uso
detect_network_interface() {
    IFACE=$(ip route | grep default | awk '{print $5}' | head -1)
    echo "Interface de rede detectada: $IFACE"
}

# Função para identificar a faixa de IP
identify_ip_range() {
    IP_RANGE=$(ip -4 addr show $IFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+')
    echo "Faixa de IP: $IP_RANGE"
}

# Função para encontrar IPs ativos na rede
scan_active_ips() {
    nmap -sn $IP_RANGE | grep "Nmap scan report for" | awk '{print $5}' > $IP_LIST
}

# Função para aplicar ferramentas nos IPs ativos
apply_tools() {
    while IFS= read -r ip; do
        echo "Aplicando ferramentas no IP: $ip"
        # Exemplo de uso das ferramentas
        sudo hping3 -S $ip -p 80 -c 1
        sudo tcpdump -i $IFACE host $ip -c 1
        sudo flood --dev $IFACE --dst $ip --port 80 -t 1 --interval 100000 --tcp --min 1200 --max 1200 -v
    done < "$IP_LIST"
}

# Menu principal
PS3='Por favor, escolha uma opção: '
options=("Instalar Ferramentas" "Analisar Rede" "Sair")
select opt in "${options[@]}"
do
    case $opt in
        "Instalar Ferramentas")
            install_tools
            ;;
        "Analisar Rede")
            detect_network_interface
            identify_ip_range
            scan_active_ips
            apply_tools
            ;;
        "Sair")
            break
            ;;
        *) echo "Opção inválida $REPLY";;
    esac
done

# Existem várias ferramentas disponíveis que permitem manipular e analisar pacotes de protocolos como TCP, UDP e ICMP, 
# cada uma com suas próprias funcionalidades e casos de uso específicos. Aqui estão algumas delas:

#  - Hping3: É uma ferramenta de linha de comando para Linux que permite analisar e montar facilmente pacotes TCP/IP.
# Além de enviar pacotes ICMP, também suporta TCP, UDP e RAW-IP. Hping3 é utilizado para diagnóstico de redes e testes de penetração, 
# oferecendo funcionalidades avançadas como enviar pacotes com intervalos específicos, "floodear" um alvo para realizar testes de 
# Denial of Service (DoS), e muito mais .

#  - Tcpdump: Esta é uma ferramenta poderosa para capturar pacotes de rede em interfaces específicas. 
# Tcpdump pode ser usado para capturar e filtrar pacotes UDP, TCP, ICMP, entre outros, o que o torna extremamente 
# útil para depuração de rede e análise de tráfego. Um exemplo de uso do Tcpdump é capturar pacotes UDP enviados 
# para um determinado porto e exibir seu conteúdo em hexadecimal e ASCII​​.

#  - Packet-Flooder: Trata-se de uma ferramenta de geração e inundação de pacotes, escrita em C, que suporta envio 
# de pacotes TCP, UDP, IPIP e ICMP. Este programa oferece funcionalidades como randomizar características de cada pacote, 
# incluindo IP de origem, porto e mais. É multithreaded, o que permite alcançar altas taxas de pacotes por segundo. 
# É importante notar que esta ferramenta deve ser usada de forma responsável, principalmente para testes de penetração e 
# não para operações ilegais como ataques de DoS​​.