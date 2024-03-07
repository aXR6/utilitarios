#!/bin/bash

# Define o diretório padrão como o diretório atual onde o script está sendo executado
DIRETORIO_PADRAO="$(pwd)"

# Função de Criptografia Simétrica
criptografar_simetrico() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    local senha=$2
    openssl enc -aes-256-cbc -salt -in "$arquivo" -out "${arquivo}.enc" -pass pass:"$senha"
    echo "Arquivo $(basename "$arquivo") criptografado com sucesso."
}

# Função de Descriptografia Simétrica
descriptografar_simetrico() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    local senha=$2
    openssl enc -aes-256-cbc -d -in "${arquivo}.enc" -out "$arquivo" -pass pass:"$senha"
    echo "Arquivo $(basename "${arquivo}.enc") descriptografado com sucesso."
}

# Função de Criptografia Assimétrica
criptografar_assimetrico() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    openssl rsautl -encrypt -inkey "${DIRETORIO_PADRAO}/chave_publica.pem" -pubin -in "$arquivo" -out "${arquivo}.enc"
    echo "Arquivo $(basename "$arquivo") criptografado com chave pública."
}

# Função de Descriptografia Assimétrica
descriptografar_assimetrico() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    openssl rsautl -decrypt -inkey "${DIRETORIO_PADRAO}/chave_privada.pem" -in "${arquivo}.enc" -out "$arquivo"
    echo "Arquivo $(basename "${arquivo}.enc") descriptografado com chave privada."
}

# Função para Criação de Arquivo
criar_arquivo() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    echo "Digite o conteúdo do arquivo e pressione Ctrl+D quando terminar:"
    cat > "$arquivo"
    echo "Arquivo $(basename "$arquivo") criado."
}

# Função para Transporte Seguro de Arquivo (Simulação)
transportar() {
    local arquivo_origem="${DIRETORIO_PADRAO}/$1"
    local destino="${DIRETORIO_PADRAO}/$2"
    read -s -p "Senha para criptografia simétrica durante o transporte: " senha
    echo
    openssl enc -aes-256-cbc -salt -in "$arquivo_origem" -out "${arquivo_origem}.enc" -pass pass:"$senha"
    echo "Arquivo $(basename "$arquivo_origem") criptografado para transporte."
    mv "${arquivo_origem}.enc" "$destino"
    echo "Arquivo transportado para $(basename "$destino")."
}

# Função para Manuseio Seguro de Arquivo (Visualização Simples)
manusear() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    echo "Conteúdo de $(basename "$arquivo"):"
    cat "$arquivo"
}

# Função para Arquivamento
arquivar() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    tar -czvf "${arquivo}.tar.gz" -C "${DIRETORIO_PADRAO}" "$(basename "$arquivo")"
    echo "Arquivo $(basename "$arquivo") arquivado em $(basename "${arquivo}.tar.gz")."
}

# Função para Destruição Segura de Arquivo
destruir() {
    local arquivo="${DIRETORIO_PADRAO}/$1"
    shred -u "$arquivo"
    echo "Arquivo $(basename "$arquivo") destruído com segurança."
}

# Menu Principal
menu() {
    while true; do
        echo "Menu do Ciclo de Vida da Informação"
        echo "1. Criar arquivo"
        echo "2. Criptografar arquivo (Simétrico)"
        echo "3. Descriptografar arquivo (Simétrico)"
        echo "4. Criptografar arquivo (Assimétrico)"
        echo "5. Descriptografar arquivo (Assimétrico)"
        echo "6. Arquivar"
        echo "7. Destruição Segura de Arquivo"
        echo "8. Transportar arquivo (Simulação)"
        echo "9. Manusear arquivo (Visualização Simples)"
        echo "10. Sair"
        read -p "Selecione uma opção: " opcao
        case "$opcao" in
            1)
                read -p "Nome do arquivo a ser criado: " arquivo
                criar_arquivo "$arquivo"
                ;;
            2)
                read -p "Nome do arquivo para criptografar: " arquivo
                read -s -p "Senha: " senha
                echo
                criptografar_simetrico "$arquivo" "$senha"
                ;;
            3)
                read -p "Nome do arquivo criptografado para descriptografar: " arquivo
                read -s -p "Senha: " senha
                echo
                descriptografar_simetrico "$arquivo" "$senha"
                ;;
            4)
                read -p "Nome do arquivo para criptografar (Assimétrico): " arquivo
                criptografar_assimetrico "$arquivo"
                ;;
            5)
                read -p "Nome do arquivo criptografado para descriptografar (Assimétrico): " arquivo
                descriptografar_assimetrico "$arquivo"
                ;;
            6)
                read -p "Nome do arquivo para arquivar: " arquivo
                arquivar "$arquivo"
                ;;
            7)
                read -p "Nome do arquivo para destruir: " arquivo
                destruir "$arquivo"
                ;;
            8)
                read -p "Nome do arquivo para transporte: " arquivo_origem
                read -p "Nome do destino (diretório/pasta): " destino
                transportar "$arquivo_origem" "$destino"
                ;;
            9)
                read -p "Nome do arquivo para manusear: " arquivo
                manusear "$arquivo"
                ;;
            10)
                exit 0
                ;;
            *)
                echo "Opção inválida!"
                ;;
        esac
    done
}

menu