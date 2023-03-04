# NOTA: Você pode realizar esses procedimentos em qualquer dispositivo que vc queira utilizar para sincronizar, via código, com o repositorio no GitHub.

# Terminal
# Para Windows com WSL:
```
Para executar os comandos deste tutorial, você já deve ter o git instalado na máquina e utilizar o terminal "Git Bash".
É possível também executar no "WSL Bash" caso você esteja utilizando a distro do Linux no Windows.
```

# Para LINUX:
```
Para Linux você só precisa ter o Git instalado e abrir o terminal.
```

# 1º - Gerar uma nova chave
```
Para criar uma chave rsa, executar: ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

# 2º - Adicionar chave privada no ssh-agent
```
Rodar o ssh-agent: eval $(ssh-agent -s)
Incluir a chave privada: ssh-add ~/.ssh/id_ed25519

```

# 3º - Copiar chave pública
```
No Windows: clip < ~/.ssh/id_ed25519.pub. (Automaticamente o conteúdo da sua chave pública será copiado para a área de transferência.)
No Linux: cat ~/.ssh/id_ed25519.pub. (O conteúdo da chave pública aparecerá no terminal para ser selecionado e copiado.)
MacOS: pbcopy < ~/.ssh/id_ed25519.pub
```

# 4º - Adicionar chave no Github
```
 - Abra o Github e vá no ícone de perfil > Settings, no canto superior direito.
 - Na barra lateral de configurações do usuário, clique em "SSH and GPG keys".
 - Clique no botão "New SSH key"
 - No campo "Título", adicione um rótulo descritivo para a nova chave. Por exemplo, se estiver usando seu computador pessoal, você pode chamar essa chave de "Computador pessoal".
 - Cole a chave pública que está na área de transferência no campo "Chave".
 - Clique em "Add SSH key" e pronto!
```

# Testando a conexão SSH
# 5º Executar o seguinte comando: ssh -T git@github.com
```
Aguardar as mensagens. Digitar "yes" para continuar.
Verifique se a mensagem resultante contém seu nome de usuário e o sucesso da sua autenticação.
```

# FEITO TUDO ISSO... AGORA É SÓ PADRONIZAR A PASTA DE TRABALHO

# 1º - Para baixar o repositorio: git clone URL_do_PROJETO

# OBS.: O RESTANTE É ESTUDO!









```
Acesse:
Thalles Canela - TSC
Canal no YouTube: https://www.youtube.com/c/aXR6CyberSecurity
Perfil no Github: https://github.com/aXR6/
Fórum: https://forum.universodoti.com.br/
```