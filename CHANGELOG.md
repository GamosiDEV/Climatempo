# Histórico de criação do projeto

## 1.0.0 - Primeira versão da aplicação (Atualizações em ordem de desenvolvimento)
* Idealização do projeto e primeiras estruturas para a criação do mesmo.
* Criação do projeto.
* Criação de Board para acompanhamento do desenvolvimento.
* Criando estrutura de pastas e padrão de organização do projeto.
    * Será utilizado padrão MVC se atentando ao máximo na limpeza do código.
* Criação de padrão de cores do APP no código.
    * Base dos Temas do Aplicativo criado porém nada foi alterado ainda, por não ter feito uma prototipagem anterior decidi esperar para ver como os layouts vão ficar e assim começar a editar suas cores e tamanhos de fonte para o Tema.
* Criação das classes Model do App.
    * Criei a base das classes Model baseando em algumas respostas da API feitas manualmente pelo navegador por mim, analisei os dados retornados e criei uma estrutura de variáveis simples para receber as informações. Nenhum método foi criado ainda, decidi aguardar a necessidade deles para evitar criar possíveis trechos de código no qual não irei utilizar.
* Criação da base do Layout das telas.
    * Aqui criei um PlaceHolder pensando em como a estrutura do APP ira ficar no futuro e preparando o mesmo para receber as futuras entradas de informações.
    * Decidi por criar placeholder para todas as possíveis telas do aplicativo sendo elas Home, Próximos dias, busca, favoritos e sobre além de uma tela para caso o aplicativo não encontre uma localização
    * Como a tela de sobre não possuía informações vindas da API já aproveitei para concluí-la colocando todas as informações, por enquanto o texto link que deveria levar ao link do portfólio leva à página inicial do google pelo fato do site ainda não está no ar portanto não ter link, este será adicionado posteriormente
* Busca de Previsão do tempo
    * Iniciei este recurso preparando a classe de controle da API para buscar as informações na mesma visto que iria precisar buscar pelas cidades e posteriormente pelas informações do tempo
    * Após algumas alterações no layout e nas buscas da API agora é possível buscar por cidades no aplicativo
    * Tornei as cidades resultado da busca feita pelo usuario clicáveis, tornando assim possível selecionar uma cidade na tela de pesquisa e em seguida ser enviado para a tela de "Clima Agora" 
    * Agora uma a tela de "Clima Agora" é aberta com uma cidade selecionada o aplicativo realiza uma requisição na API e exibe as informações referentes ao clima na cidade em questão 
    * Ainda serão necessárias alterações na tela de "Clima Agora" porem a mesma esta parcialmente concluída
* Tela de Previsão para os "Próximos dias"
    * Iniciei o processo preparando a Classe de comunicação com a API para enviar a requisição e receber as informações referentes ao mesmo
    * Após isto tornei o aplicativo capaz de trabalhar as informações vindas da API possibilitando ele solicitar uma requisição caso a tela de "Próximos Dias" fosse selecionada e então exibe as informações
        * Neste ponto avaliei a possibilidade de mesclar esta tela em conjunto com a tela de clima agora porém seria necessário realizar duas requisições simultâneas da API e como minhas requisições são limitadas preferi por manter as telas separadas visto que existe a possibilidade do usuário não abrir tela de "Próximos dias" economizando assim uma requisição à API
    * Existia um problema onde os horários não eram exibidos na "Timezone" correta, este foi corrigido neste ponto
* Tela de Favoritos
    * Preparei o aplicativo para fazer o armazenamento das informações referentes a cidades salvas nos favoritos utilizando arquivos JSON salvos no próprio sistema, visto que foi a maneira mais simples e rápida de salvar uma pequena quantia de informações no aparelho
    * Após a ocorrência de alguns erros o aplicativo agora é capaz de salvar as informações e recuperá-las normalmente, além de que quando o usuário seleciona uma cidade nos favoritos as informações referentes a ela são mostradas normalmente nas telas de previsão de tempo
* Correções menores
    * Agora caso uma cidade possua os campos "Cidade", "Estado" e "País" a requisição é feita utilizando eles e não os parâmetros de "Longitude" e "Latitude"
        * Esta medida é um caso específico visto que a informação referente ao "Estado" quase nunca é passada pela API e se perde fácil, decidi implementar isto pois havia um BUG onde algumas localidades tinham nomes trocados quando a requisição era feita utilizando apenas a "Latitude" e "Longitude".
    * O Aplicativo agora também é capaz de pegar a localização do usuário é fornecer as informações baseadas nisso e também salvar tal localização como favorita caso o usuário queira
        * Infelizmente as informações retornadas não são tão precisas devido a API ser uma versão gratuita e de fora do país, cidades pequenas podem ter suas localizações trocadas por cidades vizinhas por este motivo
    * O aplicativo agora exibe uma tela própria caso nenhuma cidade tenha sido selecionada ou encontrada pela pesquisa via GPS informando o usuário é guiando-o a tela de pesquisa ou GPS
    * Algumas alterações estéticas no aplicativo, referentes a ícones e comes
    * Um APK foi gerado e testado com alguns usuário, alguns pontos foram levantadas porém não são relevantes o suficiente para colocá-los aqui, quanto ao aplicativo o mesmo funcionou normalmente.
    * Corrigido o erro onde o nome de uma cidade buscada por GPS não aparecia ao usuário ate que a tela fosse trocada.
## 1.0.1 - Pequenas atualizações de qualidade de vida
* Correção de erros menores no código
* Polimento do código do aplicativo levanto em conta o entendimento do mesmo

## 1.0.2 - Atualização do Flutter e Dependências
* Atualizado para Flutter 3.10
* Removido do arquivo de temas "backgroundColor" que se encontrava depreciado
* Remoções de trechos de código desnecessários e melhorias na leitura e qualidade de código
