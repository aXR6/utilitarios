#!/bin/bash

# Instalar AIDE
sudo apt update
sudo apt install -y aide

# Inicializar o banco de dados de AIDE
sudo aideinit

# Mova o banco de dados para a localização padrão
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Execute a auditoria
sudo aide --check

# As diferenças serão mostradas na saída padrão. 
# Caso queira salvar em um arquivo, pode usar: sudo aide --check > /path/to/output.txt

######################
# SOBRE A FERRAMENTA #
######################

# Uma auditoria de integridade do sistema operacional pode envolver várias ações, 
# como verificar a integridade de arquivos de sistema, encontrar arquivos alterados, 
# detectar processos suspeitos, entre outras. Uma ferramenta popular para verificar a 
# integridade dos arquivos no Linux é o AIDE (Advanced Intrusion Detection Environment).

# O AIDE cria uma base de dados a partir do estado regular de um sistema, registra detalhes 
# de cada arquivo como tamanho, permissões, e hashes de conteúdo, e posteriormente pode ser 
# usado para comparar o estado atual do sistema com a base de dados inicial.

# Ao executar este script, você instalará o AIDE, inicializará sua base de dados e realizará 
# uma auditoria de integridade. As diferenças entre a base de dados e o estado atual do sistema 
# serão exibidas.