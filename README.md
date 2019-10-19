# Problem 1

Find the minimum value of x² + 100x - 16

# Problem 2

Given a graph of a social network find the least amount of profiles that is followed/friend for the most amount of distinct profiles

Dataset From : J. McAuley and J. Leskovec. Learning to Discover Social Circles in Ego Networks. NIPS, 2012.

# A fazer

* Criar metodo para atualizar população com base elitismo
* Deixar o programa preparado para várias execuções e mudança de parâmetros
* Criar função para criar csv com resultados da execução

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
