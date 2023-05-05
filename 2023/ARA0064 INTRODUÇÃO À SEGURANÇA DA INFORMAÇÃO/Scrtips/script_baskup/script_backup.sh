#!/bin/bash




# Lê o nome da pasta que será feito o backup
read -p "Digite o nome da pasta que será feito o backup: " pasta

# Verifica se a pasta existe
if [ ! -d "$pasta" ]
then
  echo "Pasta não encontrada"
  exit 1
fi

# Lê a senha do usuário
read -s -p "Digite a senha para proteger o backup: " senha
echo ""


# Define o nome do arquivo de backup
backup_file="$pasta-$(date +%Y%m%d%H%M%S).tar.gz.enc"

# Cria o arquivo de backup criptografado
tar -cz "$pasta" | openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 1000000 -salt -pass pass:"$senha" -out "$backup_file"

# Verifica se o arquivo de backup foi criado com sucesso
if [ -f "$backup_file" ]
then
  echo "Backup criado com sucesso"
else
  echo "Erro ao criar backup"
fi