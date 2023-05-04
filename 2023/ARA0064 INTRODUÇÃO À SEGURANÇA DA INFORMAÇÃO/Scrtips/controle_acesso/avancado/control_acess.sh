#!/bin/bash

# Arquivo com a lista de usuários e senhas
users_file="usuarios_senhas.txt"

# Número máximo de tentativas de acesso
max_attempts=3

# Loop principal do controle de acesso
for (( i=1; i<=$max_attempts; i++ )); do
    clear
    echo "Bem-vindo(a) ao sistema de controle de acesso"
    read -p "Digite seu nome de usuário: " username
    read -s -p "Digite sua senha: " password
    echo ""

    # Verifica se o usuário e senha são válidos
    if grep -q "^${username}:${password}$" "$users_file"; then
        echo "Acesso permitido!"
        break
    else
        echo "Acesso negado. Tentativa ${i} de ${max_attempts}."
        if (( $i == $max_attempts )); then
            echo "Número máximo de tentativas excedido. Encerrando o programa."
            exit 1
        fi
        read -p "Pressione Enter para continuar..."
    fi
done

# Continuação do script após o acesso ser permitido
echo "Seja bem-vindo(a), ${username}!"
