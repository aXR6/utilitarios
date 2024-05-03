#!/bin/bash

# Definir diretório base para a instalação
base_dir="/opt/aula_cibersuguranca"

# Criar diretório base se ele não existir
if [ ! -d "$base_dir" ]; then
    echo "Criando diretório $base_dir..."
    sudo mkdir -p "$base_dir"
fi

# Atualizar lista de pacotes e instalar pré-requisitos
echo "Atualizando lista de pacotes e instalando pré-requisitos..."
sudo apt-get update
sudo apt-get install -y git python3 python3-pip default-jdk unzip snapd

# Instalar GOBUSTER
echo "Instalando GOBUSTER..."
sudo apt-get install -y gobuster

# Instalar Sublist3r
echo "Instalando Sublist3r..."
git clone https://github.com/aboul3la/Sublist3r.git "$base_dir/Sublist3r"
cd "$base_dir/Sublist3r"
sudo pip3 install -r requirements.txt --break-system-packages

# Instalar Amass
echo "Instalando Amass..."
sudo snap install amass

# Baixar e instalar DirBuster
echo "Baixando e instalando DirBuster..."
wget https://downloads.sourceforge.net/project/dirbuster/DirBuster%20(OWASP%20ZAP)/1.0-RC1/DirBuster-1.0-RC1.zip -P "$base_dir"
unzip "$base_dir/DirBuster-1.0-RC1.zip" -d "$base_dir"
rm "$base_dir/DirBuster-1.0-RC1.zip"

# Baixar listas de palavras do SecLists para GOBUSTER e DirBuster
echo "Baixando listas de palavras do SecLists..."
git clone https://github.com/danielmiessler/SecLists.git "$base_dir/SecLists"

# Organizar listas de palavras
echo "Organizando listas de palavras..."
mkdir -p "$base_dir/Wordlists"
cp "$base_dir/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt" "$base_dir/Wordlists/"
cp "$base_dir/SecLists/Discovery/Web-Content/common.txt" "$base_dir/Wordlists/"
cp -r "$base_dir/SecLists/Discovery/Web-Content/" "$base_dir/DirBuster/DirBuster-1.0-RC1/"

echo "Instalação concluída!"
echo "Você pode executar as ferramentas da seguinte forma:"
echo " - Sublist3r: python3 $base_dir/Sublist3r/sublist3r.py -d example.com"
echo " - Amass: amass enum -d example.com"
echo " - DirBuster: java -jar $base_dir/DirBuster/DirBuster-1.0-RC1/DirBuster-1.0-RC1.jar -l $base_dir/Wordlists/directory-list-2.3-medium.txt"
echo " - GOBUSTER: gobuster dir -u http://example.com -w $base_dir/Wordlists/directory-list-2.3-medium.txt"