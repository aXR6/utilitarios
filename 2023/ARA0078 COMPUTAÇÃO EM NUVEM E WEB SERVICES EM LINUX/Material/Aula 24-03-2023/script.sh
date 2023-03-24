# Desinstalar versões antigas 
# Versões mais antigas do Docker eram chamadas de docker, docker.ioou docker-engine. Desinstale essas versões mais antigas antes de tentar instalar uma nova versão:
apt remove docker docker-engine docker.io containerd runc

# Instale usando o repositório 
# Antes de instalar o Docker Engine pela primeira vez em uma nova máquina host, você precisa configurar o repositório do Docker. Posteriormente, você pode instalar e atualizar o Docker a partir do repositório.

# Configurar o repositório
# Atualize o aptíndice do pacote e instale os pacotes para permitir apto uso de um repositório por HTTPS:
apt-get update
apt-get install ca-certificates curl gnupg

# Adicione a chave GPG oficial do Docker:
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Use o seguinte comando para configurar o repositório:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \ tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker Engine
# Este procedimento funciona para Debian em x86_64/ amd64, armhf, arm64e Raspbian.
# Atualize o aptíndice do pacote:
apt update

# Recebendo um erro GPG durante a execução apt-get update?
chmod a+r /etc/apt/keyrings/docker.gpg
apt update

# Instale o Docker Engine, o containerd e o Docker Compose.
# Para instalar a versão mais recente, execute:
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Instalação do Portainer Server
# Criando um volume
docker volume create portainer_data
# Instalando o Portainer em um container
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest

# Acessando o Portainer
# https://localhost:9443

# Primeiro Acesso
# https://docs.portainer.io/start/install/server/setup