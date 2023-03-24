sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

apt-get update

apt-get install docker-ce docker-ce-cli containerd.io

docker -version

systemctl status docker

# Instalação do Portainer Server
# Criando um volume
docker volume create portainer_data
# Instalando o Portainer em um container
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest

# Acessando o Portainer
# https://localhost:9443

# Primeiro Acesso
# https://docs.portainer.io/start/install/server/setup