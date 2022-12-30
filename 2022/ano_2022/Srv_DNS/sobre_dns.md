# O que é o DNS?
O DNS (Domain Name System – Sistema de nome de domínio) converte nomes de domínio legíveis por humanos (por exemplo, www.amazon.com) em endereços IP legíveis por máquina (por exemplo, 192.0.2.44).

# Fundamentos do DNS
Todos os computadores da internet, abrangendo de smartphones ou laptops a servidores que distribuem conteúdo para grandes websites do comércio, se encontram e se comunicam entre si usando números. Esses números são conhecidos como endereços IP. Ao abrir um navegador e acessar um site, você não precisará lembrar-se de um longo número nem digitá-lo. Em vez disso, você poderá informar um nome de domínio, como exemplo.com, e ainda assim encontrar o que deseja.

Um serviço DNS, como o Amazon Route 53, é um serviço globalmente distribuído que converte nomes legíveis por humanos, como www.exemplo.com, em endereços IP numéricos, como 192.0.2.1, usados pelos computadores para se conectarem entre si. O sistema DNS da internet funciona praticamente como uma agenda de telefone ao gerenciar o mapeamento entre nomes e números. Os servidores DNS convertem solicitações de nomes em endereços IP, controlando qual servidor um usuário final alcançará quando digitar um nome de domínio no navegador da web. Essas solicitações são chamadas consultas.

# Tipos de serviço DNS
DNS autoritativo: um DNS autoritativo disponibiliza um mecanismo de atualização que os desenvolvedores usam para gerenciar seus nomes DNS públicos. Em seguida, ele responde a consultas do DNS, convertendo nomes de domínio em endereço IP de forma que os computadores possam se comunicar entre si. O DNS autoritativo tem a autoridade final sobre o domínio, além de ser o responsável pela disponibilização de respostas para os servidores DNS recursivos com informações de endereço IP. O Amazon Route 53 é um sistema DNS autoritativo.

DNS recursivo: geralmente, os clientes não fazem consultas diretamente para os serviços DNS autoritativos. Em vez disso, eles se conectam de modo geral a outro tipo de serviço DNS conhecido como resolvedor ou serviço DNS recursivo. Um serviço DNS recursivo age como o concierge de um hotel: embora não tenha nenhum registro DNS, ele atua como um intermediário que pode obter informações de DNS por você. Se um DNS recursivo tiver a referência do DNS armazena em cache, ou armazenada durante um período, ele responderá a consulta do DNS ao disponibilizar as informações sobre a origem ou o IP. Caso contrário, ele encaminhará a consulta para um ou mais servidores DNS autoritativos para encontrar as informações.

# Como o DNS direciona o tráfego para a sua aplicação web?
O diagrama a seguir disponibiliza uma visão geral sobre como os serviços DNS recursivos e autoritativos funcionam em conjunto para direcionar um usuário final para o seu site ou a sua aplicação.

1 - Um usuário abre um navegador, digita www.exemplo.com na barra de endereços e aperta Enter. <br>
2 - A solicitação de www.exemplo.com é direcionada para um resolvedor DNS, que geralmente é gerenciado pelo ISP (Internet service provider – Provedor de serviços de internet) do usuário, como um provedor de internet a cabo, um provedor de banda larga DSL ou uma rede corporativa. <br>
3 - O resolvedor DNS do ISP encaminha a solicitação, que sai de www.exemplo.com e passa para um serviço de nome raiz DNS. <br>
4 - O resolvedor DNS do ISP encaminha novamente a solicitação de www.exemplo.com, mas desta vez para um dos servidores de nome TLD de domínios .com. O servidor de nome dos domínios .com responde a solicitação com os nomes dos quatro servidores de nome do Amazon Route 53 que estão associados ao domínio exemplo.com. <br>
5 - O resolvedor DNS do ISP escolhe um servidor de nome do Amazon Route 53 e encaminha a solicitação de www.exemplo.com para o servidor de nome em questão. <br>
6 - O servidor de nome do Amazon Route 53 procura na zona hospedada exemplo.com pelo registro de www.exemplo.com, obtém o valor associado, como o endereço IP de um servidor web (192.0.2.44) e retorna o endereço IP ao resolvedor DNS. <br>
7 - Por fim, o resolvedor DNS do ISP obtém o endereço IP de que o usuário precisa. O resolvedor retorna este valor para o navegador. O resolvedor DNS também armazenará em cache o endereço IP de exemplo.com durante um período que você especificará para que ele possa responder mais rapidamente da próxima vez que alguém pesquisar por exemplo.com. Para obter mais informações, consulte a TTL (time to live – vida útil). <br>
8 - O navegador enviará uma solicitação de www.exemplo.com para o endereço IP que obteve do resolvedor DNS. O seu conteúdo poderá ser encontrado lá. Por exemplo, um servidor web em execução em uma instância do Amazon EC2 ou um bucket do Amazon S3 que seja configurado como um endpoint do site. <br>
9 - O servidor web ou outro recurso em 192.0.2.44 retornará a página web de www.exemplo.com para o navegador que, por sua vez, exibirá a página. <br>


Link: https://aws.amazon.com/pt/route53/what-is-dns/#:~:text=O%20sistema%20DNS%20da%20internet,dom%C3%ADnio%20no%20navegador%20da%20web.