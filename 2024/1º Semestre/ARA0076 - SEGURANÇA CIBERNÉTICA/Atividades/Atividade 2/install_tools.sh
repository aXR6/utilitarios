#!/bin/bash

# Atualiza o repositório antes de começar
sudo apt update

# Função para instalar o Git se não estiver instalado
install_git() {
  if ! command -v git &> /dev/null; then
    echo "Instalando Git..."
    sudo apt install git -y
  fi
}

# Função para clonar repositórios do GitHub
clone_repo() {
  local repo_url="$1"
  local app_name="$(basename -s .git "$repo_url")"
  if [ ! -d "/opt/$app_name" ]; then
    sudo git clone "$repo_url" "/opt/$app_name"
  else
    echo "$app_name já está clonado em /opt."
  fi
}

# Função para instalar Nmap
install_nmap() {
  if ! command -v nmap &> /dev/null; then
    echo "Instalando Nmap..."
    sudo apt install nmap -y
  else
    echo "Nmap já está instalado."
  fi
}

# Função para instalar Wireshark
install_wireshark() {
  if ! command -v wireshark &> /dev/null; then
    echo "Instalando Wireshark..."
    sudo apt install wireshark -y
  else
    echo "Wireshark já está instalado."
  fi
}

# Função para instalar Metasploit Framework
install_metasploit() {
  if [ ! -d "/opt/metasploit-framework" ]; then
    install_git
    clone_repo "https://github.com/rapid7/metasploit-framework.git"
    # A instalação pode variar dependendo do sistema, este é um exemplo
    cd "/opt/metasploit-framework" && sudo ./msf_install.sh
  else
    echo "Metasploit Framework já está instalado em /opt."
  fi
}

# Função para instalar Burp Suite (Exemplo usando o instalador direto, ajuste conforme necessário)
install_burp() {
  if ! command -v burpsuite &> /dev/null; then
    echo "Instalando Burp Suite..."
    sudo apt install burpsuite -y
  else
    echo "Burp Suite já está instalado."
  fi
}

# Função para instalar Aircrack-ng
install_aircrack() {
  if ! command -v aircrack-ng &> /dev/null; then
    echo "Instalando Aircrack-ng..."
    sudo apt install aircrack-ng -y
  else
    echo "Aircrack-ng já está instalado."
  fi
}

# Função para instalar Sqlmap
install_sqlmap() {
  if ! command -v sqlmap &> /dev/null; then
    echo "Instalando Sqlmap..."
    sudo apt install sqlmap -y
  else
    echo "Sqlmap já está instalado."
  fi
}

# Função para instalar John the Ripper
install_john() {
  if ! command -v john &> /dev/null; then
    echo "Instalando John the Ripper..."
    sudo apt install john -y
  else
    echo "John the Ripper já está instalado."
  fi
}

# Função para instalar Gobuster
install_gobuster() {
  if ! command -v gobuster &> /dev/null; then
    echo "Instalando Gobuster..."
    sudo apt install gobuster -y
  else
    echo "Gobuster já está instalado."
  fi
}

# Menu de opções
while true; do
  echo "Escolha uma aplicação para instalar:"
  echo "1. Nmap"
  echo "2. Wireshark"
  echo "3. Metasploit Framework"
  echo "4. Burp Suite"
  echo "5. Aircrack-ng"
  echo "6. Sqlmap"
  echo "7. John the Ripper"
  echo "8. Gobuster"
  echo "9. Sair"
  read -p "Opção: " opt
  
  case $opt in
    1) install_nmap ;;
    2) install_wireshark ;;
    3) install_metasploit ;;
    4) install_burp ;;
    5) install_aircrack ;;
    6) install_sqlmap ;;
    7) install_john ;;
    8) install_gobuster ;;
    9) echo "Saindo..."; break ;;
    *) echo "Opção inválida!";;
  esac
done