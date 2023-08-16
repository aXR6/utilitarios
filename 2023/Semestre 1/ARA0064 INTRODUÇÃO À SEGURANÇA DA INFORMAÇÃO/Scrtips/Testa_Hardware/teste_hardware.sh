#!/bin/bash

# Função para exibir uma linha de separação
function separator {
    echo "----------------------------------------------------"
}

# Obter informações do sistema
separator
echo "Informações do sistema:"
separator
uname -a
separator
cat /etc/os-release
separator
lscpu
separator
free -h
separator
df -h
separator
ip a
separator

# Teste de CPU
echo "Teste de CPU:"
separator
sysbench cpu --threads=2 run
separator

# Teste de memória
echo "Teste de memória:"
separator
sysbench memory --threads=2 --memory-block-size=1K --memory-total-size=10G run
separator

# Teste de disco
echo "Teste de disco:"
separator
sysbench fileio --threads=2 --file-total-size=10G prepare
sysbench fileio --threads=2 --file-total-size=10G --file-test-mode=rndrw --time=300 --max-requests=0 run
sysbench fileio --threads=2 --file-total-size=10G cleanup
separator

# Teste de rede
echo "Teste de rede:"
separator
speedtest-cli
separator

echo "Benchmark concluído."