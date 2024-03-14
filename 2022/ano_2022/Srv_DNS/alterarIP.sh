#!/bin/bash

# Define o diretório a ser pesquisado
DIR="Pasta_ETC-BIND_NS1"

# Solicita ao usuário o novo IP
echo -n "Digite o novo endereço IP: "
read novo_ip

# Verifica se o novo IP é válido (formato simples)
if ! [[ $novo_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Endereço IP inválido."
    exit 1
fi

# Encontra arquivos contendo endereços IP e os altera
find $DIR -type f -exec grep -lEo '([0-9]{1,3}\.){3}[0-9]{1,3}' {} \; | while read arquivo; do
    # Substitui todos os IPs encontrados pelo novo IP
    sed -i "s/\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/$novo_ip/g" "$arquivo"
    echo "Endereço IP alterado em: $arquivo"
done

echo "Concluído."
