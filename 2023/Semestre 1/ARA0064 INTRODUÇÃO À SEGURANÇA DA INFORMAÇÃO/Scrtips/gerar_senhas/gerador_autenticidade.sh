#!/bin/bash

echo "Bem-vindo ao gerador de senhas seguras"
echo "Informe seus dados pessoais para gerar uma senha segura"
echo

# Pergunta ao usuário pelos dados pessoais
read -p "Digite seu nome: " nome
read -p "Digite seu sobrenome: " sobrenome
read -p "Digite seu CPF: " cpf
read -p "Digite sua data de nascimento (DDMMAAAA): " data_nascimento
read -p "Digite o nome da sua cidade natal: " cidade_natal

# Concatena os dados pessoais para gerar uma senha
senha="${nome}${sobrenome}${cpf}${data_nascimento}${cidade_natal}"

# Gera uma senha aleatória com base nos dados pessoais fornecidos
senha_segura=$(echo "$senha" | sha256sum | base64 | head -c 16)

# Exibe a senha segura gerada
echo "Sua senha segura é: $senha_segura"

#################################################################################################################
# Este script começa perguntando ao usuário pelos seus dados pessoais, como nome, sobrenome, data de nascimento #
# e cidade natal. Ele então concatena esses dados para gerar uma senha simples.                                 #
# Em seguida, ele usa um algoritmo de hash (SHA-256) para gerar um código criptografado da senha e,             #
# em seguida, converte esse código em uma sequência de caracteres aleatórios e seguros usando o comando base64. #
# Por fim, ele exibe a senha segura gerada para o usuário.                                                      #
#                                                                                                               #
# Lembre-se de que este é apenas um exemplo básico de como gerar senhas seguras em bash.                        #
# Para aumentar ainda mais a segurança da senha, é recomendável adicionar mais complexidade à senha,            #
# como letras maiúsculas e minúsculas, números e caracteres especiais. Também é importante proteger a           #
# senha gerada armazenando-a em um gerenciador de senhas seguro.                                                #
#################################################################################################################
