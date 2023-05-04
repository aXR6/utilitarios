#!/bin/bash

# Define o nome do arquivo a ser verificado
dados1="dados_criptografados.enc"
dados2="dados_descriptografados.txt"

criptografar_descriptografar() {
    # Define o arquivo de entrada e saída
    input_file="$1"
    output_file="$2"
    decrypted_file="$3"

    # Define a senha de criptografia
    password="$4"

    # Criptografa o arquivo de entrada usando AES-256-CBC com SHA-512, PBKDF2 e 1000000 iterações
    openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 1000000 -salt -in "$input_file" -out "$output_file" -pass pass:"$password"

    echo "Arquivo criptografado com sucesso!"

    # Descriptografa o arquivo de saída
    openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 1000000 -salt -in "$output_file" -out "$decrypted_file" -pass pass:"$password"

    echo "Arquivo descriptografado com sucesso!"
}

# Verifica se o arquivo existe
if [ -f "$dados1" ]; then
    # Remove o arquivo caso exista
    rm "$dados1" "$dados2"
    echo "---------------------------------------"
    echo "Arquivo "$dados1" e "$dados2" apagado com sucesso!"
    echo "---------------------------------------"

    criptografar_descriptografar "dados.txt" "dados_criptografados.enc" "dados_descriptografados.txt" "Nzk0MzE3ZDJhNDBj"
else
    echo "--------------------------------"
    echo "Os arquivos "$dados1", "$dados2" não existe!"
    echo "--------------------------------"

    criptografar_descriptografar "dados.txt" "dados_criptografados.enc" "dados_descriptografados.txt" "Nzk0MzE3ZDJhNDBj"
fi