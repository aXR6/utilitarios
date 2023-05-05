#!/bin/bash

# Lê os parâmetros passados pelo usuário
read -p "Informe o tamanho da senha desejado: " tamanho
read -p "Deseja incluir letras maiúsculas? (s/n): " maiusculas
read -p "Deseja incluir letras minúsculas? (s/n): " minusculas
read -p "Deseja incluir número4. BOAS PRÁTICAS EM SEGURANÇA DA INFORMAÇÃO
if [[ "$minusculas" =~ ^[sS]$ ]]; then
  opcoes+="abcdefghijklmnopqrstuvwxyz"
fi
if [[ "$numeros" =~ ^[sS]$ ]]; then
  opcoes+="0123456789"
fi
if [[ "$simbolos" =~ ^[sS]$ ]]; then
  opcoes+="!@#$%&*()_-+={}[]|\:;'<>,.?/~"
fi

# Verifica se pelo menos uma opção de caracteres foi selecionada
if [[ -z "$opcoes" ]]; then
  echo "Selecione pelo menos uma opção de caracteres."
  exit 1
fi

# Gera a senha
senha=""
while [ ${#senha} -lt $tamanho ]; do
  senha+=${opcoes:$RANDOM%${#opcoes}:1}
done

# Remove espaços em branco
senha=$(echo $senha | tr -d ' ')

# Imprime a senha gerada
echo "Senha gerada: $senha"