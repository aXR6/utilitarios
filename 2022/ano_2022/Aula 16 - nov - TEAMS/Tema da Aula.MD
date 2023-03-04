# Segurança é um estado.

# Basta comprar uma solução de segurança... será?
- Quais são efetivas para o seu cenário?
- Onde deve alocar mais recursos?
- Será que os controles são suficientes?
- Será que é possível burlar os controles implementados?
- O que um criminoso consegue fazer no meu ambiente?

Não existe sistema seguro, mas existe uma forma de melhorar a segurança e se proteger contra ciberataques.
- Conhecendo as vulnerabilidades antes do inimigo.
Obs.: Serviço de PenTest

# MODELO-----
# DEMANDA DE SERVIÇOS
# PROJETO: W.B.
# 
# EMPRESA: GOOGLE
# SETOR: EMPRESA DE PESQUISA NA INTERNET
# ESCOPO: google.com.br
# TIPO DE TESTE: PENTESTE WEB
# ABORDAGEM: (BLACK BOX)
# MODELO-----

# FASE: PREPARAÇÃO
Iniciando os testes:
- Preparando: script d1-mapear-host
- Com sistema de proteação IDS/IPS: nmap -D RND:20 --open -sS --top-ports=100 site.com.br -oN portas-abertas
- Sem sistema de proteação: nmap -D --open -sS -p- --min-rate=60000 site.com.brportas-abertas
- Sabendo as portas abertas: nmap --open -sV -p80,8080 site.com.br porta-versao

# Interfaces administrativas:
gobuster dir -u site.com.br -w /dir/dir.txt -t 100 -e --no-error -r -o gobuster
gobuster dir -u https://example.com -w /wordlists/Discovery/Web-Content/common.txt  
gobuster dir -u https://example.com -w /wordlists/Discovery/Web-Content/directory-list-2.3-small.txt -t 4 --delay 1s -o results.txt

# Testando força bruta:
Instalando SecList:
apt install seclists

hydra -v -t10 -l root "login" -P /usr/share/seclists/Passwords/2020-200_most_used_passwords.txt ftp://site.com.br -s 2121


# Obs.: Conhecimento, Execução e Resultado.
# Metodologia prática em gestão de Projetos de Pentest.
