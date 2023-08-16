#!/bin/bash

# Arquivo com a lista de usuários e senhas
users_file="usuarios_senhas.txt"

# Loop principal do controle de acesso
while true; do
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
        echo "Acesso negado. Tente novamente."
        read -p "Pressione Enter para continuar..."
    fi
done

# Continuação do script após o acesso ser permitido
echo "Seja bem-vindo(a), ${username}!"
