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

    # Verifica a força da senha
    if [[ ${#password} -lt 8 ]]; then
        echo "Senha muito fraca. A senha deve ter pelo menos 8 caracteres."
        read -p "Pressione Enter para continuar..."
        continue
    fi
    if ! [[ $password =~ [A-Z] ]]; then
        echo "Senha muito fraca. A senha deve ter pelo menos uma letra maiúscula."
        read -p "Pressione Enter para continuar..."
        continue
    fi
    if ! [[ $password =~ [a-z] ]]; then
        echo "Senha muito fraca. A senha deve ter pelo menos uma letra minúscula."
        read -p "Pressione Enter para continuar..."
        continue
    fi
    if ! [[ $password =~ [0-9] ]]; then
        echo "Senha muito fraca. A senha deve ter pelo menos um número."
        read -p "Pressione Enter para continuar..."
        continue
    fi

    # Captura o endereço IP do usuário
    ip_address=$(hostname -I)

    # Verifica se o usuário e senha são válidos
    if grep -q "^${username}:${password}$" "$users_file"; then
        echo "Acesso permitido!"
        echo "$(date): Acesso permitido para o usuário ${username}. Endereço IP: ${ip_address}" >> acesso.log
        break
    else
        echo "Acesso negado. Tentativa ${i} de ${max_attempts}."
        echo "$(date): Acesso negado para o usuário ${username}. Endereço IP: ${ip_address}" >> acesso.log
        if (( $i == $max_attempts )); then
            echo "Número máximo de tentativas excedido. Encerrando o programa."
            exit 1
        fi
        read -p "Pressione Enter para continuar..."
    fi
done

# Continuação do script após o acesso ser permitido
echo "Seja bem-vindo(a), ${username}!"
