#!/bin/bash

# Endereço do website a ser verificado
target="http://globo.com"

# Nome do arquivo de saída
output_file="vulnerabilidades.txt"

# Executa o scan utilizando o Nikto
nikto -h "$target" -output "$output_file"

# Exibe o resultado na tela
cat "$output_file"