#!/bin/bash

# Função para executar o diagnóstico de rede
diagnosticar_rede() {
  echo "Iniciando diagnóstico de rede..."

  # Executa o ping para um host de destino
  read -p "Digite o endereço IP ou o nome do host de destino: " destino
  echo
  ping -c 5 "$destino" > ping_resultado.csv
  echo "Resultado do ping salvo em 'ping_resultado.csv'"
  echo

  # Executa o traceroute para o host de destino
  echo "Executando traceroute para $destino..."
  echo
  traceroute "$destino" > traceroute_resultado.csv
  echo "Resultado do traceroute salvo em 'traceroute_resultado.csv'"
  echo

  # Executa o tcpdump para capturar pacotes na interface de rede
  read -p "Digite o nome da interface de rede para capturar pacotes (exemplo: eth0): " interface
  echo
  echo "Iniciando captura de pacotes na interface $interface..."
  echo "Pressione Ctrl+C para parar a captura."
  echo
  sudo tcpdump -i "$interface" -w tcpdump_resultado.pcap
  echo "Captura de pacotes concluída. Resultados salvos em 'tcpdump_resultado.pcap'"
}

# Executa o diagnóstico de rede
diagnosticar_rede