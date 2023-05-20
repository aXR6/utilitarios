#!/bin/bash

# Função para diagnosticar a rede e detectar handshakes
diagnosticar_rede() {
  echo "Iniciando diagnóstico de rede..."

  # Captura o tráfego na interface de rede especificada
  read -p "Digite o nome da interface de rede para capturar pacotes (exemplo: eth0): " interface
  echo
  echo "Iniciando captura de pacotes na interface $interface..."
  echo "Pressione Ctrl+C para parar a captura."
  echo

  # Executa o tcpdump para capturar pacotes na interface de rede
  sudo tcpdump -i "$interface" -n -c 1000 "tcp[tcpflags] & (tcp-syn|tcp-ack) == (tcp-syn|tcp-ack)" > captura_pacotes.txt &

  # Cria arquivo CSV para armazenar os resultados
  handshake_csv="handshakes.csv"
  touch "$handshake_csv"

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

    # Filtra apenas as linhas de handshakes e salva em um arquivo CSV
    grep "IP" captura_pacotes.txt | awk '{print $1","$3","$5","$8}' > "$handshake_csv"

    # Exibe os resultados
    echo "Handshakes capturados:"
    cat "$handshake_csv"
    echo

    # Aguarda um intervalo de 5 segundos antes de realizar a próxima análise
    sleep 5
  done
}

# Executa o diagnóstico de rede
diagnosticar_rede