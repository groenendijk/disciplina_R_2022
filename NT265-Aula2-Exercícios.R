##### Exerc?cios Aula 2 - Dataframes ###

#### Exercicio 1 - Dados e distribuições #####

#Rode as seguintes linhas:
set.seed(42) #Esse comando faz com que todas as pessoas obtenham a mesma sequencia aleatoria que será gerada a seguir:

peciolo <- rnorm(n=100, mean=3, sd=0.5)

# Você acabou de criar um objeto chamado peciolo que contem valores comprimento de peciolo de folhas de Aspidosperma
# Esse objeto possui 100 elementos numéricos com distribuição normal
# A média desses 100 valores é 3
# O desvio padrão (sd = standard deviation) é de 0.5

#Calcule a média dos valores de comprimento de peciolo. A função para calcular médias é mean()
#Qual foi o valor minimo de comprimento de peciolo? Use a função min()
#Salve esse valor minimo em um objeto chamado pec.min
#Qual foi o valor maximo de comprimento de peciolo? Use a função max()
#Salve esse valor maximo em um objeto chamado pec.max
#Crie um vetor chamado min.max concatenando os objetos pec.min e pec.max
#Crie um vetor chamado pec.intervalo que contenha o intervalo de valores de peciolo, use a função range
#Verifique por meio de uma operação lógica se os valores do objeto min.max são iguais aos do objeto pec.intervalo 

#Para ver o histograma de frequência dos dados:
hist(peciolo)
#Como se lê um histograma de frequ?ncias:
#No eixo x estão os intervalos de valores de peciolo (ex. de 1.5 a 4.5 cm para peciolos)
#No eixo y estão a frequencia relativa com que ocorrem esses valores no vetor
#A soma dessas frequ?ncias ? 100%
#Por exemplo, aproximadamente 4% dos valores de peciolo estão entre 1.5 e 2 cm
#Aproximadamente 11% dos valores de peciolo estão entre 2.0 e 2.5 cm
#Aproximadamente 31% dos valores de peciolo estão entre 2.5 e 3.0 cm
#E assim por diante

#Veja que a maioria dos valores de peciolo estão entre 1.5 e 2.5 cm
#Ou seja, os valores estão geralmente distribuídos em volta da m?dia
#Se fossemos desenhar uma linha em volta do histograma, ela teria a forma de um sino
#Quanto maior o numero de elementos em um vetor, mais próximo ele ficar? de uma distribuição normal
#Veja:
hist(rnorm(n=10   , mean=3, sd=0.5))
hist(rnorm(n=100  , mean=3, sd=0.5))
hist(rnorm(n=1000 , mean=3, sd=0.5))
hist(rnorm(n=10000, mean=3, sd=0.5))

# Ao sortear um numero dentro de peciolo, é mais provavel que ele esteja proximo do valor médio = 3?
# E é menos provavel que ele seja menor que 2 cm ou maior que 4 cm

## Agora rode o seguinte comando

folha <- runif(n=100, min=12, max=15)
hist(folha)

#Compare visualmente os histogramas de peciolo e folha
hist(peciolo)

# Voce percebe alguma diferença?

# O formato do histograma de peciolo é muito diferente do de folha:
hist(runif(n=100,   min=12, max=15))
hist(runif(n=1000,  min=12, max=15))
hist(runif(n=10000, min=12, max=15))
hist(runif(n=100000,min=12, max=15))

# Na função runif, a probabilidade de distribuição é uniforme entre os valores 12 e 15
# Ao sortear um valor de folha, é igualmente provavel encontrar o valor minimo (12) ou maximo (15)
# Isso é tudo que você precisa saber sobre distribuições por enquanto. 

#### Exercicio 2 - Criar data frames #####

# Criar um data frame chamado Disciplina com 150 linhas. VocÊ pode criar vetores separados para cada coluna e juntá-los.
# A primeira coluna vai se chamar "Aluno" e vai conter numeros de 1 a 15, com repetições sequenciais de cada um, 10 vezes (ex, numero 1 dez vezes, numero 2 dez vezes, etc).
# A segunda coluna vai se chamar "Aula". Essa coluna vai conter 10 sequencias de numeros de 1 a 15 (ex, sequencia de 1 a 15 seguida de sequencia de 1 a 15, 10 vezes)
# Dica: usar rep() usando o argumento times ou o argumento each.
# Criar a terceira coluna chamada "Nota" com valores de distribuição normal com média 7 e desvio padrão 2. (Dica: usar rnorm())
# Juntar as colunas em um data frame chamado Disciplina, se você ainda não juntou

# Fazer um boxplot com os alunos no eixo X e as notas no eixo y
# Adicionar o titulo dos eixos (Alunos para x e Notas para y)
# Criar uma coluna chamada nome_aluno que em vez de números tenha os nomes: Bruna, Diego, Gabriel, Giovani, Guilherme, Jéssica, João Victor, Larissa, Marcela, Patricia, Paula, Tami, Tamires, Victor e Wagner
# Dica: crie um vetor com esses nomes usando rep(), como acima, e salve na coluna nome_aluno. Para criar essa coluna, use o nome do dataframe colchetes e o nome da coluna entre aspas.
# Refaça o boxplot com o nome dos alunos ao invés de números
# Coloque os nomes dos alunos em maiusculo 
# Se quiser só a primeira letra em maísculo, baixe o pacote Hmisc, use a funcao capitalize()). Nao se esqueça de carregar o pacote (library(Hmisc))
# Refaça o grafico boxplot com o nome dos alunos perpendicular ao eixo x.
# Manipule a margem do grafico para caber os nomes (usando par(mar=c(...)))
# Mude a cor dos boxplots para a sua cor favorita


## Agora vamos manipular os dados da planilha
# Imagine que a nota de cada dia tem o peso aumentado a cada aula. A nota da primeira aula vale 1, da segunda aula vale 2, e assim por diante. Calcule a nota de cada aluno em cada aula. Dica: é só multiplicar a coluna Nota pela coluna Aula. Salve essa multiplicação na coluna nota_mult do dataframe Disciplina.
# Calcule o logaritmo na base 10 de nota_mult e salve na coluna nota_log (Dica: use a funcao log10())
# Altere o nome da coluna nota_log para nota_logaritmica (use colnames() e colchetes)

# Crie um novo data frame chamado Pessoas selecionando apenas a coluna alunos do data frame Disciplina. Dica: use colchetes e o nome da coluna entre aspas.
# Crie uma segunda coluna no data frame Pessoas chamada nome_maius nesse data frame com o nome dos alunos com todas as letras maiusculas (dica: use toupper()).
# Crie uma terceira coluna no data frame Pessoas chamada nota_exercicios e crie a nota_exercicios de cada aluno usando a funcao runif() com o valor minimo de nota 0 e o maximo 10
# Apague a coluna nome_maius do data frame Pessoas. Não sabe como fazer? Não se desespere, pergunta pro Google! 

## Faça um grafico tipo boxplot com as notas de exercicios dos alunos
# Edite os titulos dos eixos. No eixo x "Nome dos alunos", no y "Nota de exercicio". Coloque o nome dos alunos perpendicular ao eixo x

# Nossa, preciso de uma lista do nome dos alunos, sem repetições:
nomes <- unique(Pessoas[,"alunos"]) #valore únicos nesta coluna

# Vamos criar um data frame que contenha o nome dos alunos na primeira coluna (nomes) e na segunda coluna, adicione o texto "legal" ao nome dos alunos, separados por espaços (dica: use paste())

# E se eu quiser uma cor diferente para cada aluno no boxplot?
boxplot(Pessoas[,"nota_exercicios"]~Pessoas[,"alunos"], col = nomes, las=3)

## Desafio:
# E se eu quiser mudar a ordem dos alunos? Coloque a Victor antes dos outros alunos e refaça o boxplot. Dica: mude a coluna alunos para factor usando as.factor(). Depois modifique os niveis desse fator usando o argumento levels = c(), da função factor() para mudar a ordem 

#### Exercicio 3 - Trabalhar com data frames #####

## Veja que usando
Pessoas[1:10,] #Você seleciona as notas de exercicio do Victor
#E que usando
Pessoas[-c(1:10),] #Você remove as linhas relativas a Victor

#Apague as linhas do dataframe relativas as nota_exercicios do Luan, pois ele não esta matriculado na disciplina e salve esse novo data frame como Pessoas2. 
#Use View(Pessoas) para ver quais sao as linhas do Luan

#Ao invés de precisar usar View(Pessoas), podemos usar operações lógicas para selecionar linhas referentes alunos. 
#Veja:
Pessoas[,"alunos"] == "Patricia"

#Aqui temos uma pergunta. Os elementos da coluna aluna do data frame pessoa são iguais ao texto Patricia? A resposta é verdadeira ou falsa (TRUE ou FALSE) para cada um dos elementos da coluna alunos.
#Para saber quais são os elementos verdadeiros, usamos which:
which(Pessoas[,"alunos"]=="Patricia")

#Podemos salvar o numero das linhas que são referentes a Patricia em um objeto chamado Patricia_linhas:
Patricia_linhas <- which(Pessoas[,"alunos"]=="Patricia")
#Podemos criar um objeto Pessoas3 removendo as linhas referentes a Patricia:
Pessoas3 <- Pessoas[-Patricia_linhas,]

#Descubra qual linhas sao referentes a Larissa usando which()
#Salve o nome das linhas referentes a Larissa em um objeto nota_exercicios_Larissa
#Remova as linhas referentes a Larissa do data frame Pessoas3 e salve como Pessoas4

#Veja que o comando abaixo mostra as linhas do data frame Pessoas referentes a Patricia:
Pessoas[Patricia_linhas,]

# Você pode salvar as linhas referentes a Patricia em um novo dataframe:
Patricia_nota_exercicios <- Pessoas[Patricia_linhas,]

# Salve as linhas referentes a Wagner  em um dataframe com o Wagner_notaexercicios
# Calcule o valor medio das notas dela nos exercicios de cada aula e salve em um objeto chamado Wagner_media
# Calcule a media geral da turma do objeto Disciplina, coluna Nota.
# Qual a diferença entre a média do Wagner e a média da turma?

#### Exercicio EXTRA - Estatística #####

# Que tipo de variável é o nome dos alunos e que tipo são suas notas (categorica, discreta ou continua)?
# Qual análise eu usaria para comparar notas entre alunos (um teste para comparar médias)?
# E se separassemos os alunos entre mestrandos e doutorandos e quiséssemos comparar as médias de suas notas, qual teste usaríamos?

# Vamos tentar fazer uma ANOVA (ANalysis Of VAriance = Análise de Variância)?
comp_notas <- aov(Pessoas[,"nota_exercicios"]~Pessoas[,"alunos"])
comp_notas # o que é salvo no objeto é uma lista de informações sobre os dados de entrada

# Para saber o resultado, usamos summary:
summary(comp_notas)

# Por enquanto veja que o valor de p (Pr(>F)) é maior do que 0.05. Isso significa que não existe diferençaa significativa entre as notas dos alunos.

## Vamos acresentar uma coluna chamada estudo no data frame Pessoas que vai conter o tempo (em min) que cada aluno passou estudando os scipts depois da aula. Essa coluna vai ser gerada usando uma distribuicao normal com média 120 e desvio padráo de 40

# Vamos testar se existe alguma relação entre o tempo de estudo e a nota dos alunos?

lm(Pessoas[,"nota_exercicios"]~Pessoas[,"estudo"])
# Esse comando devolve a formula e os coeficientes de uma regress?o linear (lm = linear model)

# Vamos salvar essa regressao em um objeto chamado regressao
regressao <- lm(Pessoas[,"nota_exercicios"]~Pessoas[,"estudo"])

# Para saber o resultado, usamos novamente a função summary
summary(regressao)
# Veja que a regressão gera um valor de intercepto que é onde a linha da regressão cruza o eixo y (4.6425 para mim)
# E um valor de inclinação, que é o angulo da reta (0.001243 para mim)
# Não existe uma relacao significativa entre tempo de estudo e nota, pois o valor de p associado à inclinação da reta não é menor que 0.05

# Vamos fazer gráficos?
par(mfrow=c(1,2), mar=c(6,6,2,1))
# Veja que par(mfrow=c(1,2)) cria um painel de gráficos com 1 linha e duas colunas de gráficos
plot(Pessoas[,"nota_exercicios"]~Pessoas[,"alunos"], las=3, xlab="", ylab="Notas")
plot(Pessoas[,"nota_exercicios"]~Pessoas[,"estudo"])
abline(regressao, lwd=2) # Essa é a linha da regressao, como ela é quase horizontal (inclinacao muito baixa), não existe relacao entre as variaveis.


# Crie uma coluna chamada sono que vai conter o numero de horas medias que os alunos dormem por noite, usando uma distribuicao uniforme com valor minimo de 6 e maximo de 9
# Verifique se ha diferen?as de horas de sono entre os alunos usando uma anova
# Verifique se ha relacao entre as horas de sono e as notas dos alunos usando uma regressao linear
# Faca um grafico para cada analise e plote esses graficos lado a lado usado par(mfrow)

#### Exercicio EXTRA - Distribuições e densidade de probabilidade ####

# Existem vários tipos de distribuições e histogramas e curvas de densidade de probabilidade são uma boa forma de visualizar as distribuições.

## Distribuiãao normal
peciolo <- rnorm(n=10000, mean=3, sd=0.5)
hist(peciolo)

## O que acontece com o histograma se variarmos a média e o desvio padrão de peciolo?

pec.posx <- seq(from=0, to=6, length=1000)# Cria um vetor com possíveis valores de comprimento de pecíolo

# Variando apenas o valor médio de comprimento de peciolo:
d.peciolinho <- dnorm(pec.posx, mean=2, sd=0.5)
d.peciolo    <- dnorm(pec.posx, mean=3, sd=0.5)
d.peciolao   <- dnorm(pec.posx, mean=4, sd=0.5)

plot(x= pec.posx, y= d.peciolo, type="l", lwd=3,          
     ylab="Densidade de probabilidade", 
     xlab="Comprimento de peciolo")
# Veja que primeiro precisamos criar uma figura com os valores para peciolo
# no eixo x entram os valores poss?veis de peciolo (pec.posx)
# no eixo y entram as densidades de probabilidade associadas a esses valores
# O tipo de grafico é de linha (type="l")
# A espessura da linha=3 (lwd = line width)
# xlab = titulo do eixo x (x label)
# ylab = titulo do eixo y (y label)

# Podemos adicionar linhad de densidade de probabilidade para peciolinhos e pecioloes:
# Para isso usamos a função lines() junto com um argumento (novo) para a cor da linha (col)
lines(x= pec.posx,y= d.peciolinho, type="l", lwd=3, col="red")
lines(x= pec.posx,y= d.peciolao,   type="l", lwd=3, col="blue")

## Viram que o formato da curva não muda?
# O que muda é o valor medio de comprimento de peciolo

## Vejam que o rnmorm() cria uma sequencia aleatoria de valores com distribuição normal
## O dnorm() calcula a densidade de probabilidade de um certo valor ocorrer dentro dos valores

# Variando apenas o desvio padrão de comprimento de peciolo:
d.peciolo1 <- dnorm(pec.posx, mean=3, sd=0.5)
d.peciolo2 <- dnorm(pec.posx, mean=3, sd=1)
d.peciolo3 <- dnorm(pec.posx, mean=3, sd=1.5)

plot(pec.posx,d.peciolo1,  type="l", lwd=3,  ylab="Probability Density")
lines(pec.posx,d.peciolo2, type="l", lwd=3, col="red")
lines(pec.posx,d.peciolo3, type="l", lwd=3, col="orange")

# Viram que o formato da curva muda? 
# Desvio padrões maiores levam a uma curva mais achatada
# A probabilidade de encontrar valores mais variaveis ? maior

# E como calcula a probabilidade do peciolo ter entre 2 e 3 cm?
pnorm(3, mean=3, sd=0.5) - pnorm(2, mean=3, sd=0.5)
# A probabilidade de encontrar valores de comprimento de peciolo entre 2 e 3 é quase 50%

# Vamos ver no grafico? Veja que type="n" não plota nada, apenas os eixos
plot(pec.posx, d.peciolo, type="n", xlab="Comprimento de peciolo (cm)", 
     ylab="Densidade de probabilidade")
i <- pec.posx >= 2 & pec.posx <= 3 #O objeto i vai conter todos os elementos de pec.posx entre 2 e 3
lines(pec.posx, d.peciolo)
polygon(c(2,pec.posx[i],3), c(0,d.peciolo[i],0), col="purple") 

# Calma! Tá tudo bem, você só está rodando um script pronto
# Aos poucos você irá aprender a escrever o seu próprio script

# Vamos tentar fazer?
# Crie uma sequencia chamada petala com 100 valores entre 4 e 6
# Calcule a densidade de probabilidade para os valores de petala considerando uma distribuição normal com média 5 e desvio padrão 0.2
# Salve essa densidade de probabilidade em um objeto chamado d.petala
# Dica: use dnorm()
# Façaa um grafico de linha com a densidade de probabilidade de petala
# O titulo do eixo x do grafico deverá ser "Comprimento de petala (cm)"
# O titulo do eixo y do grafico deverá ser "Densidade de probabilidade"

## Chega ou quer mais?
# Desafio 1: Calcule a probabilidade de encontrar valores de comprimento de petala entre 1 e 2 cm
# Desafio 2: Calcule a probabilidade de encontrar valores de comprimento de petala menores que 1.5 cm
