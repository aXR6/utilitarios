#!/bin/bash

# Verifica se o arquivo pcapng foi fornecido como argumento
if [ $# -ne 1 ]; then
  echo "Uso: $0 arquivo.pcapng"
  exit 1
fi

# Verifica se o comando tshark está instalado
if ! command -v tshark >/dev/null; then
  echo "O comando 'tshark' não foi encontrado. Vamos instalar para você."
    # Instalar o tshark
    apt update && apt install -y tshark wireshark
    apt autoremove -y
  exit 1
fi

# Define o arquivo de entrada
arquivo_pcapng=$1

# Define o arquivo CSV de saída
arquivo_csv="informacoes.csv"

# Extrai as informações usando o tshark e redireciona a saída para o arquivo CSV
tshark -r "$arquivo_pcapng" -T fields -E separator=, -E header=y \
  -e frame.number \
  -e frame.time \
  -e ip.src \
  -e ip.dst \
  -e tcp.srcport \
  -e tcp.dstport \
  -e udp.srcport \
  -e udp.dstport \
  -e http.request.method \
  -e http.host \
  -e http.user_agent \
  -e http.response.code \
  -e dns.qry.name \
  -e dns.resp.name \
  -e dns.resp.type \
  -e dns.resp.ttl \
  -e tls.handshake.ciphersuite \
  -e tls.handshake.ciphersuite \
  -e tls.handshake.session_id \
  -e tls.handshake.certificates \
  >"$arquivo_csv"

# Verifica se a extração foi bem-sucedida
if [ $? -eq 0 ]; then
  echo "Extração concluída. As informações foram armazenadas em '$arquivo_csv'."
else
  echo "Ocorreu um erro durante a extração das informações."
fi