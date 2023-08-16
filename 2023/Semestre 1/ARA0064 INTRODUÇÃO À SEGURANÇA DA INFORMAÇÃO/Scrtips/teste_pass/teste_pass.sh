#!/bin/bash

# Função para testar a segurança de uma senha
function test_password_security() {
  # Ler a senha do usuário
  read -p "Digite a senha: " senha
  
  # Verificar o comprimento da senha
  if [ ${#senha} -lt 8 ]
  then
    echo "Senha muito curta"
    return
  fi
  
  # Verificar se a senha contém caracteres especiais
  if ! [[ "$senha" =~ [^a-zA-Z0-9] ]]
  then
    echo "Senha não contém caracteres especiais"
    return
  fi
  
  # Verificar se a senha contém letras maiúsculas e minúsculas
  if ! [[ "$senha" =~ [A-Z] && "$senha" =~ [a-z] ]]
  then
    echo "Senha não contém letras maiúsculas e minúsculas"
    return
  fi
  
  # Verificar se a senha contém números
  if ! [[ "$senha" =~ [0-9] ]]
  then
    echo "Senha não contém números"
    return
  fi
  
  # Se a senha atende a todos os critérios, exibir uma mensagem de sucesso
  echo "Senha segura"
}

# Testar a segurança da senha
test_password_security
