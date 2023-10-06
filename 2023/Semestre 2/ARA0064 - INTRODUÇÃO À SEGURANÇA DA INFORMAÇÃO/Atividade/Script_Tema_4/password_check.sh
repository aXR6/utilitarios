#!/bin/bash

# Script para verificar a força da senha no Debian

# Função para avaliar a força da senha
check_password_strength() {
    local passwd="$1"
    local strength=""
    local score=0

    # Verificar o tamanho da senha
    if [[ ${#passwd} -ge 8 ]]; then
        let "score += 1"
    fi

    # Verificar se contém números
    if [[ $passwd =~ [0-9] ]]; then
        let "score += 1"
    fi

    # Verificar se contém letras maiúsculas e minúsculas
    if [[ $passwd =~ [a-z] ]] && [[ $passwd =~ [A-Z] ]]; then
        let "score += 1"
    fi

    # Verificar se contém caracteres especiais
    if [[ $passwd =~ [^a-zA-Z0-9] ]]; then
        let "score += 1"
    fi

    case $score in
        4) strength="Forte";;
        3) strength="Média";;
        2) strength="Fraca";;
        1) strength="Muito Fraca";;
        *) strength="Inaceitável";;
    esac

    echo "Força da Senha: $strength"
}

# Solicitar senha do usuário
read -s -p "Digite sua senha (não será exibida): " password
echo ""
check_password_strength "$password"