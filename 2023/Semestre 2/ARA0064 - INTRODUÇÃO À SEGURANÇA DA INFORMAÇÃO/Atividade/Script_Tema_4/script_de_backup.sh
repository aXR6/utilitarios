#!/bin/bash

# Script de Backup para Debian

# Diretório de origem do backup
SOURCE_DIR="/caminho/para/diretório/de/origem"

# Diretório de destino do backup
DEST_DIR="/caminho/para/diretório/de/destino"

# Nome do arquivo de backup
DATE=$(date +%Y-%m-%d)
BACKUP_NAME="backup_$DATE.tar.gz"

# Verificar se o diretório de origem existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erro: Diretório de origem não encontrado!"
    exit 1
fi

# Verificar se o diretório de destino existe
if [ ! -d "$DEST_DIR" ]; then
    echo "Erro: Diretório de destino não encontrado!"
    exit 1
fi

# Realizar o backup
echo "Realizando backup de $SOURCE_DIR para $DEST_DIR/$BACKUP_NAME ..."
tar -czf "$DEST_DIR/$BACKUP_NAME" "$SOURCE_DIR"

# Verificar se o backup foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Backup realizado com sucesso!"
else
    echo "Erro durante o backup!"
    exit 1
fi