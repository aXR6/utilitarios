#!/bin/bash

# Função para diagnosticar a rede e detectar ataques de DoS
diagnosticar_rede() {
  echo "Iniciando diagnóstico de rede..."

  # Captura o tráfego na interface de rede especificada
  read -p "Digite o nome da interface de rede para capturar pacotes (exemplo: eth0): " interface
  echo
  echo "Iniciando captura de pacotes na interface $interface..."
  echo "Pressione Ctrl+C para parar a captura."
  echo

  # Executa o tcpdump para capturar pacotes na interface de rede
  sudo tcpdump -i "$interface" -n -c 10000 > captura_pacotes.txt &

  # Cria arquivos CSV para armazenar os resultados
  pacotes_origem_csv="pacotes_origem.csv"
  portas_destino_csv="portas_destino.csv"
  touch "$pacotes_origem_csv"
  touch "$portas_destino_csv"

  # Loop para analisar os pacotes capturados em tempo real
  while true; do
    # Verifica se a captura de pacotes ainda está em execução
    if ! pgrep -f "tcpdump -i $interface" >/dev/null; then
      echo "Captura de pacotes finalizada."
      break
    fi

    # Realiza análise em tempo real dos pacotes capturados
    echo "Realizando análise em tempo real dos pacotes capturados..."
    echo

    # Faz a contagem de pacotes de origem por endereço IP e salva em um arquivo CSV
    awk '{print $3}' captura_pacotes.txt | awk -F. '{print $1"."$2"."$3"."$4}' | sort | uniq -c | sort -nr | head -n 10 > "$pacotes_origem_csv"

    # Faz a contagem de pacotes por porta de destino e salva em um arquivo CSV
    awk '{print $5}' captura_pacotes.txt | awk -F: '{print $2}' | sort | uniq -c | sort -nr | head -n 10 > "$portas_destino_csv"

    # Exibe os resultados
    echo "Top 10 endereços IP de origem com mais pacotes:"
    cat "$pacotes_origem_csv"
    echo

    echo "Top 10 portas de destino com mais pacotes:"
    cat "$portas_destino_csv"
    echo

    # Aguarda um intervalo de 5 segundos antes de realizar a próxima análise
    sleep 5
  done
}

# Executa o diagnóstico de rede
diagnosticar_rede