##### Exerc?cios Aula 1 ###

#### Exercício 1 - Operações lógicas #####

#Verifique por meio de uma operação lógica se 1 é maior que 2.
#Salve o resultado dessa operação em um objeto chamado "nao".
#Verifique por meio de uma operação lógica se 2 é maior que 1.
#Salve o resultado dessa operaação em um objeto chamado "sim".
#Verifique se o valor do objeto "sim" é maior que o valor do objeto "nao".
#Isso ocorre pois ao TRUE é atribuído o valor de 1 e ao FALSE o valor de 0.

#Verifique por meio de uma operação lógica se 2 é igual a 2 e salve o resultado em um objeto "c"
#Verifique por meio de uma operação lógica se 2 é diferente de 2.1 e salve o resultado em um objeto "d"
#Verifique se "c" é igual a "d"
#Por que isso ocorreu?

#Verifique por meio de uma operação lógica se 2 e 3 são iguais a 3
#Verifique por meio de uma operação lógica se 2 ou 3 são iguais a 3
#Verifique por meio de uma operação lógica se 2 é menor ou igual a 3

#### Exercicio 2 - Criar objetos #####

#Crie um objeto chamado "a", com valor 18
#Calcule a área de um quadrado com lado de "comprimento = a" 
#Salve o valor da área em um objeto chamado "b"

#Agora vamos para 3 dimensões!
#Usando os objetos a e b, calcule o volume de um cubo de lado a
#Se você esqueceu a fórmula para calcular volume de um cubo, pergunte ao google ;D
#Agora calcule o volume desse cubo usando apenas o objeto a usando exponenciação (^)

#### Exercício 3 - Criar vetores #####

#Crie um vetor chamado "flores" que contenha 5 vezes o elemento "petala", 5 vezes "sepala" e 5 vezes "estigma".
#Dica: use a função rep()
#Dica: concatene os elementos do vetor usando c()

#Verifique quantos elementos tem o vetor flores (dica: use length())
#verifique a classe do vetor "flores" e a classe do vetor "comprimento"
#transforme o vetor "flores" para a classe fator usando coerção
#verifique a classe do vetor "flores" novamente

#Crie um vetor chamado "comprimento" que contenha os seguintes valores: 5,4,5,6,5,3,2,3,1,2,1,1.5,2,1.3,1.4
#Veja qual é o quarto elemento do vetor "comprimento"
#Salve esse elemento em um novo objeto chamado "quarto_elemento"
#Verifique se o primeiro elemento do vetor "comprimento" é igual ao terceiro elemento do mesmo vetor

#Crie um novo vetor chamado "subcomp" que contenha do primeiro até o quarto e do décimo segundo até o décimo quinto elemento de "comprimento"
#Quantos elementos tem nesse vetor subcomp?

#Desafio: faça um boxplot dos valores de comprimento em função das partes da flor

#### Exercicio 4 - Trabalhar com vetores #####

#Crie uma sequencia de 1 a 15 contendo 20 valores e salve essa sequencia em um vetor chamado "vinte." Lembre-se de usar a função rep() para isso!
#Crie um vetor que repita CADA valor da sequencia "vinte", três vezes, com o mesmo elemento repetido na sequencia. Esse vetor vai se chamar "sessenta"
#Crie um vetor que repita a sequencia vinte, integralmente, tres vezes, Esse vetor vai se chamar sessenta2

#### Exercicio 5 - Condições em vetores  #####

#Crie um vetor chamado floresta e outro chamado savana onde 
#floresta possui os seguintes valores de diametro de 
#arvores: 3, 12, 5, 1, 7, 10. Savana possui os seguintes diametros: 
# 9.9, 3.1, 4.2, 7.6,  12.9, 13

# Verifique se floresta tem valores menores do que 5 
# Verifique se savana tem valores maiores do que 5? 

# O parametro de inclusão para medidas de biomassa nestas arvores 
# é de pelo menos 10 cm de diametro. Existem arvores em ao menos uma delas que 
# entrem neste criterio de inclusao? 


# Crie um objeto chamado floresta com os valores de diametro das arvores: 3, 4, 7, 9, 10, 12, 15, 19. Agora crie um vetor chamado savana com os seguintes valores de diametro de arvores:  4, 2, 1, 2, 3, 9, 20, 11. 

# A floresta possui arvores maiores ou iguais a 5.5?
# Savana tem valores menores do que 15? 
# Existem arvores menores do que 9 em floresta e maiores do que 9 na savana?

# O criterio de inclusao de individuos arboreos para levantamento de biomassa é de individuos com diametro maior ou igual a 10. Ha individuos nestas areas que entram neste criterio? 

#DESAFIO#
#Salve em um obejto chamado "dap" os diamentros dos individuos que entram neste criterio. Você pode fazer isso na mão, mas com os conhecimentos que já possui pode automatizar esa seleção no R. Pode perguntar ao R quais valores são maiores que 10 em cada vegetação, no entanto essa pergunta pode ser direcionada à seleção de elementos dentro dos vetores floresta e savana. Lembre-se como selecionar elementos dentro do vetor. Veja que dominar esta técnica é o primeiro passo pra filtrar dados!

#Qual o valor do segundo elemento de dap?

# Selecione os elementos 1 e 4 de dap e eleve os a potencia de 5.

# Calcule o logaritmo neperiano dos elementos 2 e 5.

# Crie uma floresta e uma savana de mil arvores baseado apenas nos diametros que possui para cada um dos ambientes e salve em veg.flo e veg.sav, respectivamente.

# Calcule a media e desvio padrao de cada uma das vegetacoes virtuais que criou