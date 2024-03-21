#!/bin/bash

# Função para Diffie-Hellman
diffie_hellman() {
    echo "Gerando parâmetros Diffie-Hellman..."
    openssl dhparam -out dhparams.pem 2048
    echo "Parâmetros Diffie-Hellman gerados e salvos em 'dhparams.pem'"
}

# Função para ElGamal
# Nota: OpenSSL não suporta ElGamal diretamente. Este exemplo simplificado usa DSA para fins demonstrativos.
elgamal() {
    echo "Gerando chaves DSA (usado aqui como exemplo simplificado de ElGamal)..."
    openssl dsaparam -out dsaparam.pem 2048
    openssl gendsa -out privkey.pem dsaparam.pem
    openssl dsa -in privkey.pem -pubout -out pubkey.pem
    echo "Chaves DSA geradas. Chave privada: 'privkey.pem', Chave pública: 'pubkey.pem'"
}

# Função para Criptografia de Curvas Elípticas
curvas_elipticas() {
    echo "Gerando chaves de Curva Elíptica..."
    openssl ecparam -name prime256v1 -genkey -out ec_private.pem
    openssl ec -in ec_private.pem -pubout -out ec_public.pem
    echo "Chaves de Curva Elíptica geradas. Chave privada: 'ec_private.pem', Chave pública: 'ec_public.pem'"
}

# Menu principal
while true; do
    echo "Selecione o algoritmo de criptografia:"
    echo "1. Diffie-Hellman"
    echo "2. ElGamal (via DSA)"
    echo "3. Curvas Elípticas"
    echo "4. Sair"
    read -p "Opção: " opt

    case $opt in
        1)
            diffie_hellman
            ;;
        2)
            elgamal
            ;;
        3)
            curvas_elipticas
            ;;
        4)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Por favor, tente novamente."
            ;;
    esac
done
