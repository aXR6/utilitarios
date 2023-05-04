#!/bin/bash

# Arquivo com a lista de usuários e senhas
users_file="usuarios_senhas.txt"

# Número máximo de tentativas de acesso
max_attempts=3

# Variáveis para teste de força da senha
has_uppercase=false
has_lowercase=false
has_number=false
has_special=false

# Loop principal do controle de acesso
for (( i=1; i<=$max_attempts; i++ )); do
    clear
    echo "Bem-vindo(a) ao sistema de controle de acesso"
    read -p "Digite seu nome de usuário: " username
    read -s -p "Digite sua senha: " password
    echo ""

    # Verifica o nível de segurança da senha
    if [[ "$password" =~ [A-Z] ]]; then
        has_uppercase=true
    fi

    if [[ "$password" =~ [a-z] ]]; then
        has_lowercase=true
    fi

    if [[ "$password" =~ [0-9] ]]; then
        has_number=true
    fi

    if [[ "$password" =~ [\!\@\#\$\%\^\&\*\(\)\-\_\+\=\{\}\[\]\;\:\'\"\,\<\.\>\/\?\|\\] ]]; then
        has_special=true
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

# Captura o endereço IP do usuário
ip_address="$(echo $SSH_CONNECTION | awk '{print $1}')"

# Salva o log de acesso em um arquivo
log_file="logs.txt"
date="$(date "+%Y-%m-%d %H:%M:%S")"
echo "${date} - Usuário ${username} com endereço IP ${ip_address} acessou o sistema." >> "$log_file"

# Continuação do script após o acesso ser permitido
echo "Seja bem-vindo(a), ${username}!"
echo "Senha segura? $(($has_uppercase + $has_lowercase + $has_number + $has_special))/4"
