# Habilitando repositorios de terceitos
- Forma automatica? <br>
apt update <br>
apt install -y software-properties-common <br>
apt-add-repository contrib <br>
apt-add-repository non-free <br>

- Forma manual: <br>
cd /etc/apt/ <br>
ls -la  <br>
nano sources.list <br>
Obs.: Acrescencer na frente de "main" -> non-free contrib <br>
CTRL + S (salvar) <br>
CTRL + x (saiar) <br>

# Atualizando lista do repo...
apt update

# Instalando atualizações...
apt dist-upgrade -y

# Instalando componentes necessarios...
apt install -y apt-transport-https wget ca-certificates gnupg2 wget git open-vm-tools dirmngr curl

# Instalando app necessarios...
apt install -y apache2 php phpmyadmin mariadb-server mariadb-client && apt autoremove -y

# Configurando um nivel de segurança
cat >'/etc/apache2/conf-available/security.conf' <<EOT <br>

#ServerTokens Minimal <br>
#ServerTokens OS <br>
#ServerTokens Full <br>
ServerTokens Prod <br>
#ServerSignature Off <br>
#ServerSignature On <br>
ServerSignature Off <br>

EOT

# Verificar que a sintaxe do ficheiro de configuração está correta
apachectl -t

# einiciar o servidor apache2
systemctl restart apache2

# Em primeiro lugar deve ser ativado o módulo ssl
a2enmod ssl

# Reiniciar o servidor apache2
systemctl restart apache2

# Durante a instalação do apache2 é criada uma configuração para acesso seguro (https)
cat >'/etc/apache2/sites-available/default-ssl.conf' <<EOT

                #   SSL Engine Switch:
                #   Enable/Disable SSL for this virtual host.
                SSLEngine on

                #   A self-signed (snakeoil) certificate can be created by inst$
                #   the ssl-cert package. See
                #   /usr/share/doc/apache2/README.Debian.gz for more info.
                #   If both key and certificate are stored in the same file, on$
                #   SSLCertificateFile directive is needed.
                # SSLCertificateFile      /etc/ssl/certs/ssl-cert-snakeoil.pem
                # SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key

                # Certificados Let's Encrypt:
                #SSLCertificateFile    /etc/letsencrypt/live/home.example.com/cert.pem
                #SSLCertificateKeyFile /etc/letsencrypt/live/home.example.com/privkey.pem

                # Certificados auto-assinados:
                SSLCertificateFile     /etc/ssl/certs/server.crt
                SSLCertificateKeyFile  /etc/ssl/private/server.key

EOT

# O novo site também deve ser ativado
a2ensite default-ssl <br>
apachectl -t <br>

# Reiniciar o servidor apache2
systemctl restart apache2

# Reiniciar o servidor apache2
apt install -y certbot

# O certbot é um utilitário que facilita a emissão e renovação dos certificados Let’s Encrypt
certbot certonly --non-interactive --standalone --agree-tos --email pinguim.ribeiro@gmail.com -d home.example.com <br>

cert.pem - O certificado para o nosso domínio <br>
chain.pem -	O certificado intermédio (Let's Encrypt) <br>
fullchain.pem - O nosso certificado (cert.pem) e o certificado intermédio (chain.pem) da Let’s Encrypt<br>
privkey.pem - A chave privada do certificado <br>

# CONFIGURANDO USUARIO E BANCO NO MARIADB (PROCEDIMENTO MANUAL)
1º - Acessando o MariaDB <br>
mysql -p -uroot

# 2º - Criando usuario
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';

# 3º - Concede todos os privilégios ao usuário
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'localhost' IDENTIFIED BY 'mypassword';

# 4º - Conceder privilégios a um banco de dados específico
GRANT ALL PRIVILEGES ON 'DB1'.* TO 'user1'@'localhost';

# 5º - Lembre-se de atualizar os privilégios
FLUSH privileges;

# 6º - Para verificar as concessões do usuário no MariaDB
SHOW GRANTS FOR 'myuser'@'locahost';