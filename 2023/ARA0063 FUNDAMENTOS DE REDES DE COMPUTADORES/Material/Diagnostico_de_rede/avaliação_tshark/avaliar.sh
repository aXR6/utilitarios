#!/bin/bash

# Caminho para o arquivo de captura do Wireshark
capture_file="teste.pcapng"

# Caminho para o arquivo de saída
output_file="saida.txt"

# Verifica se o arquivo de captura existe
if [ ! -f "$capture_file" ]; then
    echo "Arquivo de captura '$capture_file' não encontrado."
    exit 1
fi

# Exibe as informações gerais do arquivo de captura e salva no arquivo de saída
echo "Informações do arquivo de captura:" > "$output_file"
tshark -r "$capture_file" -z io,phs >> "$output_file"

# Extrai estatísticas de protocolos e salva no arquivo de saída
echo "Estatísticas de protocolos:" >> "$output_file"
#tshark -r "$capture_file" -qz "proto,colinfo" >> "$output_file"
tshark -r "$capture_file" -Y "frame.len>0" -T fields -e ip.proto | sort | uniq -c | sort -nr


# Analisa os pacotes e extrai informações específicas e salva no arquivo de saída
echo "Análise de pacotes:" >> "$output_file"
tshark -r "$capture_file" -T fields -e frame.number -e frame.time -e ip.src -e ip.dst -e tcp.srcport -e tcp.dstport -e udp.srcport -e udp.dstport -e icmp.type -e icmp.code -e http.host -e http.request.method -e http.response.code >> "$output_file"

echo "Análise concluída. Resultados salvos em '$output_file'."


# O script utiliza o tshark para executar várias operações no arquivo de captura:

# tshark -r "$capture_file" -z io,phs exibe informações gerais do arquivo de captura, incluindo estatísticas de I/O e resumo de cabeçalhos.
# tshark -r "$capture_file" -qz "proto,colinfo" extrai estatísticas de protocolos presentes no arquivo de captura.
# tshark -r "$capture_file" -T fields -e <campos> analisa os pacotes e extrai informações específicas, como número do pacote, horário, endereços IP, portas TCP/UDP, tipos e códigos ICMP, e detalhes de requisições HTTP. Você pode adicionar ou remover os campos desejados na linha correspondente.