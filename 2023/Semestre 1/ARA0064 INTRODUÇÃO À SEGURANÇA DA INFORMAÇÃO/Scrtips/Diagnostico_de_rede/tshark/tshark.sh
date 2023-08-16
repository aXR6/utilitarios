#!/bin/bash

# Verifica se o comando tshark está instalado
if ! command -v tshark >/dev/null; then
  echo "O comando 'tshark' não foi encontrado. Por favor, instale o Wireshark."
  exit 1
fi

# Define o nome do arquivo de saída
arquivo_saida="analise_trafego.csv"

# Define o número máximo de pacotes a serem capturados
num_pacotes=100

# Define os filtros de captura
filtros=""

# Função para capturar e analisar o tráfego
capturar_trafego() {
  echo "Capturando tráfego..."

  # Inicia a captura de pacotes com tshark
  tshark -i enp4s0 -c "$num_pacotes" $filtros -T fields \
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
    -e tls.handshake.session_id \
    -e tls.handshake.certificates \
    | sed 's/\t/,/g' >"$arquivo_saida"
  
  echo "Captura concluída. Os resultados foram armazenados em '$arquivo_saida'."
}

# Função para exibir o arquivo de saída
exibir_resultados() {
  echo "Resultados da análise de tráfego:"
  echo
  cat "$arquivo_saida"
}

# Menu principal
while true; do
  echo "===== Análise de Tráfego ====="
  echo "1. Capturar tráfego"
  echo "2. Exibir resultados"
  echo "3. Sair"
  echo

  read -p "Digite o número da opção desejada: " opcao

  case $opcao in
    1)
      capturar_trafego
      ;;
    2)
      exibir_resultados
      ;;
    3)
      echo "Saindo..."
      exit 0
      ;;
    *)
      echo "Opção inválida. Por favor, escolha uma opção válida."
      ;;
  esac

  echo
done