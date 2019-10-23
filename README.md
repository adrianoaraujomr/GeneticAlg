# Problem 1

Find the minimum value of x² + 100x - 16

# Problem 2

Given a graph of a social network find the least amount of profiles that is followed by the most amount of distinct profiles

Dataset From : J. McAuley and J. Leskovec. Learning to Discover Social Circles in Ego Networks. NIPS, 2012.

# Dicas para os Slides

## Problema 1

### Algoritmo

* Objetivo minimizar : x² + 100x - 16
* Seleção por roleta
* Cruzamento por média
* Mutação por incremento/decremento
* Atualização da população é feita já no cruzamento, comparando fitness novo com o dos pais

### Gráficos

**estao na branch adriano/master**

* fail_sn_01 : diretório tem os gráficos que mostram que o algoritmo não se estabilizava no minimo, mesmo começando com ele na População.
* fail_sn_02 : a população começava longe do minimo, caminhava ate ele e passava.
* square_graphs : mostra o algoritmo se estabilizando no minimo global.
* entre os fail e o square a mudança que teve foi no operador de mutação, que invez de so incremetar o decrementar a variavel ele tinha 50% de chance de fazer um ou outro.

## Problema 2

### Algoritmo

* Objetivo : Dado um grafo representando uma rede social, achar o menor número de perfis (nos do grafo) de modo a maximizar o número de perfis distintos alcançaveis a partir dos nós selecionados.
* Quase o problema de achar o clique de um grafo, porém não se tem garantia que ele existe.
* Seleção : Torneio de dois um é escolhido
* Cruzamento : por ponto ou por troca de nos
* Mutação : remoção/adição/troca de nos (1/3 prob)
* Atualização da população é feita percorrendo um vetor de filhos e se eles tiverem um fitness dominante em relação ao vetor de população a troca é feita

### Gráficos

**estao na branch adriano**

* sub_cross x point_cross : comparação de cruazamento diferentes probabilidas em README.txt em cada um dos diretórios
* aggressive : testa mutação adicionando uma maior quantidae de nos, ver se sub_cross avança mais

# Parametros para mudar

### População

* n : Número de individuos da população : SPopulation.new(n,$sonet.keys)
* Mudar a forma de atualizar a população pode ser interessante

### Individuo

* @@prob_mutation : Probabilidade de ocorrer uma mutação
* @@prob_crossing : Probabilidade de ocorrer um cruzmento
* a, b : Qual o intervalo de sorteio do tamanho do individuo : val = rand(a) + b
* Mudar como o cruzamento ocorre e como a mutação ocorre pode ser interessante também

### Método de seleção

* sr : Alterar a quantidade de individuos selecionados : @selection.run(eval,sr)
* Alterar forma de ocorrer torneio

### Algoritmo Genético

* @@generations : Número de gerações/iterações

### Observação

* Olhar se o algoritmo esta com tendencia de so aumentar/diminuir nos ou se fica parado

# To Do

* juntar crossing por ponto com a mutação aggressive
* fazer script em python para ler os csv e fazer gráficos com as melhores outputs
* se possível implementar seleção por EVO
