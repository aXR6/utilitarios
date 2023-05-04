#!/bin/bash

# Arquivo com a lista de usuários e senhas
users_file="usuarios_senhas.txt"

# Número máximo de tentativas de acesso
max_attempts=3

# Verificação do nível de segurança da senha
password_strength() {
    password="$1"
    if [[ $(echo "$password" | wc -c) -lt 8 ]]; then
        echo "Senha muito curta. Utilize pelo menos 8 caracteres."
        return 1
    elif [[ ! "$password" =~ [0-9] ]]; then
        echo "Senha fraca. Utilize pelo menos um número."
        return 1
    elif [[ ! "$password" =~ [a-zA-Z] ]]; then
        echo "Senha fraca. Utilize pelo menos uma letra."
        return 1
    else
        echo "Senha forte. Parabéns!"
        return 0
    fi
}

# Loop principal do controle de acesso
for (( i=1; i<=$max_attempts; i++ )); do
    clear
    echo "Bem-vindo(a) ao sistema de controle de acesso"
    read -p "Digite seu nome de usuário: " username
    read -s -p "Digite sua senha: " password
    echo ""

    # Verifica o nível de segurança da senha
    if ! password_strength "$password"; then
        if (( $i == $max_attempts )); then
            echo "Número máximo de tentativas excedido. Encerrando o programa."
            exit 1
        fi
        read -p "Pressione Enter para continuar..."
        continue
    fi

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