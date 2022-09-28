# Habilitando repositorios de terceitos
# ACESSE: https://github.com/aXR6/utilitarios/tree/main/Aula-Protocolos/Srv_Web
# OBS.: APENAS PARA A CONSTRUÇÃO DO SRV WEB.

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









```
Acesse:
Thalles Canela - TSC
Canal no YouTube: https://www.youtube.com/c/aXR6CyberSecurity
Perfil no Github: https://github.com/aXR6/
Fórum: https://forum.universodoti.com.br/
```