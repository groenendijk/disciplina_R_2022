######### Aula 2 Tabelas no R: Dataframes ### 

#### Anotaçõees gerais ####

## Soft-wrap! [Code > Soft-wrap long lines]
## Menus colapsáveis!
## Usar espaços, ENTER, etc.

## Indicar pasta de trabalho
# Configurar o R para trabalhar desde um diretório, para encontrar e executar arquivos
# Este será o seu diretório de trabalho (working directory = wd)
# Nos seus documentos, criar um diretório chamado DisciplinaR_UNICAMP com subdiretórios: Codigo, Dados e Resultados
getwd()
setwd("C:/Users/Peter\\OneDrive - Universidade Estadual de Campinas/Documents/Disciplinas/NT265 - R e gráficos/2022/DisciplinaR_UNICAMP/")
#setwd(".../DisciplinaR_UNICAMP") 

# Observe que o Windows usa barra deitada ( \ ) para separar pastas
# O R usa a barra invertida ( / ) ou a barra deitada dupla ( \\ ), usei ambas para ilustrar

### ********* VOLTA PRO POWERPOINT ********* ###

#### Vetores recap ####

## Vamos criar vetores:
meses        <- c("janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro")
precipitacao <- c(222, 203,	147, 56, 49, 47, 29, 26, 64, 125, 142, 205)
temperatura  <- c(22.1,	21.9, 21.7,	19.6, 17.1,	15.7, 15.7,	16.6, 18.3,	19.7, 21.5,	21.6)

meses
precipitacao

## Verifica classes dos vetores
is.numeric(precipitacao) # Estamos perguntando se a é da classe numérica
!is.numeric(meses)       # Estamos perguntando se a NÃO é da classe numérica
is.character(meses)      # Estamos perguntando se a é da classe caracteres (texto)

## Dá pra aninhar / juntar funções! 
is.logical(!is.numeric(meses)) 

## coerção - mudando um objeto de uma classe para outra
class(meses)
meses <- as.factor(meses) # (re)cria o objeto meses a partir do objeto meses, transformando a classe em fator
class(meses)
meses # como virou fator, agora também aparecem os Levels

## seleção de um dos valores de um vetor
meses[1]      # Primeiro elemento do vetor
meses[c(3:7)] # elementos 3,4,5,6,7 do vetor
# Note que além do primeiro valor, também mostra os Levels (os níveis que há em um vetor fatorial!)

meses <- as.character(meses) # transformaremos de volta para caracteres, pois fator e caracter funcionam de forma diferente (problemas com classes dados são muito comuns!!). Para os próximos passos precisaremos dos meses como caracter

## operações matematicas aplicadas sobre um vetor

precipitacao * 2   
temperatura ^ 2
sqrt(precipitacao) # raíz quadrada = square root

precipitacao / temperatura # funciona se os dois vetores tiverem o mesmo tamanho (ou se o segundo for um valor único (ex: temperatura <- 2))

# Podemos fazer todo tipo de transformações com vetores de texto também. 
# Alguns exemplos simples, há vários pacotes para se trabalhar com texto

toupper(meses)
tolower(meses)

### ********* VOLTA PRO POWERPOINT ********* ###

#### Organização de vetores ####

vit <- c (2, 5, 20, 3, 8, 100, 350) # criamos um vetor simples

rank(vit, ties.method = "first")  # dá a posição de cada um dos valores em ordem crescente (ranqueamento)
sort(vit, decreasing = T)  # ordena os valores por ordem crescente
order(vit) # dá ordem de posiçõees de cada elemento que precisaríamos usar para fazer uma seleção em ordem crescente. uhum...

# Vamos criar um vetor dessas posições usando o order
vit_order <- order(vit)

# Agora vamos usar esse vetor para fazer uma seleção dos elementos do vetor vit 
# que nem fizemos mais pra cima
vit[vit_order] # seleção dos elementos de vit que cria uma re-ordenação de vit em ordem crescente 

# bora fazer pra precipitacao?
rank(precipitacao) 
sort(precipitacao)
order(precipitacao)

# Funciona também para vetores de texto
rank(meses)  # da a posição de cada mÊs, em ordem alfabetica
sort(meses)  # ordena em ordem alfabetica
order(meses) # posições para ordenar, em ordem alfabética

### ********* VOLTA PRO POWERPOINT ********* ###

#### Tabelas no R: dataframes ####
## Vamos criar uma tabela com a precipitação e temperatura mensal em Campinas

cbind(meses, precipitacao, temperatura) #cbind é a função que combina colunas (to bind = amarrar)

#Aparece no console, mas faltou salvar como objeto
climacamp <- as.data.frame(cbind(meses, precipitacao, temperatura))
climacamp <- as.data.frame(climacamp)
View(climacamp) # abrir o dataframe para visualisar (note o V maiusculo!), também funciona clicar duas vezes no nome do objeto na aba "Environment" ao lado

# Há vários caminhos para se chegar em Roma, outra opção é criar o dataframe usando a função data.frame
# Note que aqui criamos o objeto novamente, perdemos a versão anterior (ainda que aqui elas sejam iguais)
climacamp <- data.frame(meses        = meses,        # notaram o uso 
                        precipitacao = precipitacao, # de espaços
                        temperatura  = temperatura)  # e do ENTER??
View(climacamp)

# Finalmente, outra opção é colocar os vetores dentro da função data.frame() 
# Aqui nãoo precisa primeiro criar os objetos para os vetores individuais. 
# Dependendo da situação vale a pena criar os objetos (se vai usá-los mais tarde) ou 
# fazer tudo dentro da fórmila (se quiser "economizar" no número de objetos criados e a memória do computador sendo usada). 

climacamp <- data.frame(meses=c("janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"),
                        precipitacao = c(222, 203, 147, 56, 49, 47, 29, 26, 64, 125, 142, 205),
                        temperatura = c(22.1, 21.9, 21.7, 19.6, 17.1, 15.7, 15.7, 16.6, 18.3, 19.7, 21.5, 21.6)
                        ) # fecha parentesis! 

View(climacamp)

# Esse formato de tabela é conhecido como formato longo (long format), 
# cada coluna é uma variável e todas observações uma embaixo da outra
# é o formato mais usado no R (pacote ggplot2 usa, pacotes de estatastica também) 
# é o formato mais comum de se encontrar em bases de dados. 
# Em princípio é o formato (mais) correto de se guardar os dados.

# Existem obviamente várias formas de se salvar dados e algumas áreas usam formatos próprios
# Outro formato comum é o formato largo, no qual os dados ficam um do lado do outro 
# Algumas funções usam o formato largo:

climalargo <- rbind(precipitacao, temperatura) #rbind é a função que combina linhas (= row bind)
colnames(climalargo) <- meses #Estou adicionando os meses como nome das colunas
View(climalargo)

barplot(climalargo["precipitacao",], las=2) # plot de barras da precipitação
barplot(climalargo["temperatura",],  las=2) # argumento las = 2 indica que o texto do eixo x tem que estar girado 90 graus

### ********* VOLTA PRO POWERPOINT ********* ###

# Pra que usar esses parenteses quadrados []? Os colchetes.
# Pra que eles servem? Vocês já usaram antes, com os vetores! 
# Pra selecionar os elementos da tabela que você precisa usar
# Você usa assim: nomedodataframe["nomedalinha", "nomedacoluna"]
# Quando você deixa o nome da linha (ou da coluna) em branco você seleciona todas linhas (ou colunas)
# Veja:

climalargo["temperatura",]          # toda a linha temperatura
climalargo[,"janeiro"]              # toda a coluna janeiro
climalargo["temperatura","janeiro"] # o elemento na linha temperatura e coluna janeiro

# Funciona com os números (das linhas ou colunas) também 
climalargo[,2]
climacamp[,2]

# Veremos mais sobre seleção de colunas (a indexação) na aula que vem! 

## Um data.frame tem duas dimensões (colunas e linhas) e essas dimensões podem ter nomes
# Qual o nome das linhas e das colunas do dataframe?
rownames(climalargo) #Nome das linhas
colnames(climalargo) #Nome das colunas

rownames(climalargo) <- c("chuva", "calor")
View(climalargo)

colnames(climalargo) <- toupper(colnames(climalargo))

### ********* VOLTA PRO POWERPOINT ********* ###

#### Tabelas maiores ####

mesessp        <- rep(meses,      each = 100)
precipitacaosp <- rnorm(n = 1200, mean = 109, sd = 50)
temperaturasp  <- rnorm(n = 1200, mean = 21,  sd = 3)

plot(precipitacaosp)
hist(precipitacaosp)

climasp <- data.frame(meses = mesessp, 
                      precipitacao = precipitacaosp, 
                      temperatura = temperaturasp)

str(climasp)  # Te dá estrutura da sua tabela com dados basicos de cada coluna
head(climasp, n = 3) # Para visualizar as seis primeiras linhas da tabela
tail(climasp) # Para visualizar as seis ultimas linhas da tabela

### ********* VOLTA PRO POWERPOINT ********* ###

## E se eu quiser adicionar colunas?

climasp[,4] <- NA # Podemos criar uma coluna sem nenhum valor
colnames(climasp) # Veja que a nova coluna tem o nome de V4 (variável 4)

# Podemos dar um nome a nova coluna:
colnames(climasp)[4] <- "umidade"
head(climasp) 

# Escolhemos o quarto elemento do vetor de nomes de coluna e subistituimos V4 por "umidade"

#Vamos adicionar valores à umidade?

climasp[,4] <- runif(n=1200, min=15, max=95) # o que é runif?
head(climasp)
#Lembre-se que é o mesmo que:
climasp[,"umidade"] <- runif(n=1200, min=15, max=95)

hist(climasp[,"umidade"])

# E quando as coisas desandam (a.k.a. bem vind@ à realidade)


climasp[2,3] <- NA # Inserimos um dado faltante (NA = not available) na linha 2 da 3a coluna

# Vamos calcular a média de temperatura (coluna 3)?
mean(climasp[,3])

# Com um dado faltante não é possivel calcular média da temperatura em sp
# E agora? É só remover o dado faltante:
mean(climasp[,3], na.rm=TRUE) 
# na.rm significa na remove (remover dados faltantes do cálculo de média)

# E para remover a linha toda da tabela?
# Em qual linha está o dado faltante mesmo?
is.na(climasp[,3])

# Aqui são 1200 elementos, e o R mostra amenas os 1000 primeiros!
# Qual o elemento da terceira coluna é um dado faltante?
which(is.na(climasp[,3]))

# O segundo elemento da coluna 3 da tabela climasp é um NA
climasp[2,3]# Só verificando

# E se a gente remover a segunda linha?
climasp2 <- climasp[-2,] # indexador negativo remove valores!

# Agora podemos calcular a média sem erros:
mean(climasp2[,3])

# Mas lembre-se que tinhamos um valor para precipitacão na outra coluna que foi removido quando removemos a linha toda.
# Remover a linha toda nem sempre é eficiente se temos que trabalhar com outras variaveis do data.frame
# Usar na.rm nas funções (ex. mean()) é mais recomendado para evitar perda de dados

### ********* VOLTA PRO POWERPOINT ********* ###

#### Visualização de dados ####

# Vamos visualizar os dados? Fazer um boxplot!
# Primeiro faremos como na aula anterior, selecionando dois vetores: 
# um correspondente à coluna temperatura no dataframe climasp e o outro correspondente à coluna meses:
boxplot(climasp[,"temperatura"] ~ climasp[,"meses"])

# Dá pra fazer de uma forma mais agradável? SIM!!!
boxplot(data = climasp, temperatura ~ meses) # indicando o nome do dataframe (data = climasp), podemos só digitar os nomes das colunas para indicar as variáveis

# Os meses não aparecem, vamos melhorar?
boxplot(data = climasp, temperatura~meses, 
        las=3, col="salmon") # corzinha bonita!

# Vamos adicionar o titulo dos eixos?
boxplot(data = climasp, temperatura~meses, 
        las=3, col="salmon",
        xlab="Meses", 
        ylab= "Temperatura (°C)") # lab = label

# E se quisermos um titulo para o grafico?
boxplot(data = climasp, temperatura~meses, 
        las=3, col="salmon",
        xlab="Meses", 
        ylab= "Temperatura (?C)",
        main="Temperatura mensal média inventada em SP")

# E se não quisermos mais o titulo?
boxplot(data = climasp, temperatura~meses, 
        las=3, col="salmon",
        xlab="Meses", ylab= "Temperatura (?C)",
        main="")

# Mas fica esse espaço horrível acima do gráfico e o xlab está esprimido
par(mar = c(6,4,1,1), # Altera margens da figura (inferior, esquerda, superior, direita)
    mgp = c(5,1,0))   # Posicionamento dos valores dos eixos (titulo, valores, marcadores) 
boxplot(data=climasp, temperatura ~ meses,
        las=3, col="salmon",
        xlab="Meses", 
        ylab= "") # Não plotar o títlo do eixo y
mtext(side=2, text= "Temperatura (?C)", line=2.5) # Adiciona o titulo do eixo y separadamente

### Trabalhoso, mas mais bonito! ###

dev.off() # Reseta os parametros graficos de par (mar e mgp), também limpa os gráficos na memória

#### Adicionais ####

#E se eu quiser que os meses aparecam com a primeira letra em maiusculo?
##Aprender a alterar textos (strings) no R

install.packages("Hmisc")
library(Hmisc)

capitalize(climasp[,1]) #Deu certo? Se não der, veja qual classe de dados é essa coluna
class(climasp[,1])

# Se os meses forem lidos como fator, não dá certo. Só se forem lidos como caracteres:
climasp[,1] <- as.character(climasp[,1])
climasp[,1] <- capitalize(climasp[,1])  #Agora sim a primeira letra está maiuscula

# E para transformar todas em maiuscula?
climasp[,1] <- toupper(climasp[,1])
head(climasp)

#E para retornar todas para minuscula?
climasp[,1] <- tolower(climasp[,1])
head(climasp)

#Assim é mais bonito:
climasp[,1] <- capitalize(climasp[,1])
head(climasp)

#E se eu quiser adicionar o ano após o mês?
climasp[,1] <- paste(climasp[,1], "2018", sep= " ") # Paste() = colar / concatenar texto
head(climasp)

##E se eu quiser separar o ano do mês?
#Vamos separar o mês e o ano usando strip split (separaçãoo de texto) e unlist para criar um vetor

mesano <- unlist(strsplit(x = climasp[,1] , split=" "))
mesano

#Agora temos um vetor com 2400 elementos de texto
#Vamos criar uma matriz para acomodar esses elementos em 1200 linhas e 2 colunas?
matriz <- matrix(data = mesano, ncol = 2, byrow = TRUE )
head(matriz)

#Para manipular a matriz, é melhor trasformá-la em data frame
# Lembrando que matriz só aceita uma classe de dados (caracter, numérico, etc.)
matriz <- as.data.frame(matriz)

#Agora vamos adicionar t?tulo ?s colunas:
colnames(matriz) <- c("mes", "ano")
class(matriz)
head(matriz)

climasp[,5] <- matriz[,1]
colnames(climasp)[5] <- "mes"

climasp[,6] <- matriz[,2]
colnames(climasp)[6] <- "ano"
head(climasp)  
