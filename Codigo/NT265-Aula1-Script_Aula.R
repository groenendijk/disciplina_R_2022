### Aula 1 Introdução ao R e RStudio ### 

## Mostrar as diferentes janelas, abas, busca, etc

## Usando texto no script: Se você adicionar o símbolo "#" o R entende que o texto é um comentário
## O texto que está após o "#" não é rodado

#### Título 1 - Introdução ####
## Se você usar 4 ou mais # depois do título, o RStudio lê como título e cria um "sumário" facilmente acessível no campo abaixo da janela de scripts

2+5

2-5

2/5

2^5

2*(2-5)

1:10

log10(100)# Log na base 10 do numero 100

log2(3) # Log na base 2 do numero 3

log(10) # Logaritmo natural (ln)

sqrt(16) # Raiz-quadrada de 16 (square root)

### Volta para a aula ppt

#### Operações lógicas ####

5>2 #5 ? maior que 2?
5<2 #5 ? menor que 2?
5>=2 #5 ? maior ou igual a 2?
5<=2 #5 ? menor ou igual a 2?
5==2 #5 ? igual a 2?
5!=2 #5 ? diferente de 2?

2+3==3+2
2*3==4+2

2>1 & 3 >1 #Os numeros 2 e 3 s?o maiores que 1?
3>4 & 4 > 4 #Os numeros 3 e 4 s?o maiores que 4?
3!=5 & 4!= 5 #Os numeros 3 e 4 s?o diferentes de 5?


3>4 | 4>4 #Os numeros 3 OU 4 s?o maiores que 4?
3==4 | 4 == 4 #Os numeros 3 OU 4 s?o iguais a 4?
3!=4 | 4!= 4 #Os numeros 3 OU 4 s?o iguais a 4?

### Volta para ppt da aula 

#### Classes de objetos ####

# Para que o R leia textos, é necessário coloca-lo entre aspas

"Insira aqui o seu texto"
3+2   #Aqui o R faz uma soma e mostra o produto disso
"3+2" #Agora 3+2 nao é mais uma soma a ser realizada e sim um texto

#Como eu sei se o R está lendo como texto, como números ou como operação lógicagica ?
#É só perguntar!
class(3+2)
class("3+2")
class(3>2)
class(1)

# Criando objetos

a <- 5

#Veja que agora o objeto "a" aparece no Global Environment (Janela superior direita)
#Os objetos criados podem ser listados pelo comando ls()

ls()
b <- 6

# qual a classe do objeto "a"?
class(a)

#Veja que é diferente de perguntarmos
class("a")

#Podemos substituir o valor de a
a <- 2

#Podemos salvar o valor de "a" dentro de outro objeto

outroobjeto <- a

#Podemos fazer operações matemáticas com objetos
a+b

sim<-5>2
nao<-2>5

sim > nao # Isso ocorre pois no R TRUE equivale a 1 e FALSE equivale a 0

### Volta para ppt da aula

#### Verificação e coerção de classes ####

#verificação
is.numeric(a)#Estamos perguntando se a é da classe numerica
!is.numeric(a)

is.character(a)#Estamos perguntando se a é da classe caracter (texto)
is.logical(a>v)#Ainda nao criamos o objeto v

#coerção - mudando um objeto de uma classe para outra
a <- as.character(a)
class(a)#Agora a é lido como caracter ("2")
a+b#Essa operação nao é mas possível pois não podemos somar textos e números

#retornando o objeto a para caractere
a<-as.numeric(a)
class(a)
a+b

### Volta para ppt da aula

#### Criação de vetores ####

#A função c() significa concatenar:
numero<- c(1, 2, 3, 4)
numero

#É possível escolher um elemento do vetor:
numero[2]

a <- c(3,4,5,6)

a[c(1,2)] #Para escolher mais de um elemento do vetor

a[c(1,          2)] #Espaços são ignorados

## Espaços são amigos! Semelesémaisdifícillerascoisas!!

a[1:2] # Isso é a mesma coisa

a(1,2) # Isso seria chamar a função a com argumentos 1 e 2 (não existe função a)

numero+a # É possível fazer operações com vetores:

a <- c(1,2,3)
b <- c(2,1)
a+b ## a e b tem o mesmo tamanho?
#Este é um caso de ciclagem.
#Operações entre vetores de comprimentos distintos são feitas
#pareando seus elementos. Os elementos do vetor mais curto são repetidos
#sequencialmente até que a operaço seja aplicada a todos os
#elementos do vetor mais longo. É conveniente, no entanto é muito perigoso!

#É possível criar vetores de várias classes
texto <- c("a", "b", "c", "d")
class(texto) # Veja que o vetor é texto

#Selecionar o segundo elemento do vetor ("b")
texto[2]
segundo <- texto[2] # Salvar o segundo elemento em um outro objeto chamado segundo

## Concatenar vetores para criar um terceiro vetor:

vetor <- c(a,b)
vetor
class(vetor)#Veja que o vetor é numérico

jantinha <- rep(c("arroz", "feijao", "brocolis"), each=5)
jantinha
class(jantinha)
jantinha <- as.factor(jantinha)
jantinha #Agora jantinha ? um fator com tr?s n?veis

p.arroz    <-c(2,3,2,4,1)
p.feijao   <-c(5,6,8,6,7)
p.brocolis <-c(10,11,12,8,9)

proteina <- c(p.arroz, p.feijao, p.brocolis) #proteina ? um vetor com 15 elementos num?ricos

#Vamos entender um pouco sobre os vetores:
length(proteina) #Quantos elementos tem o vetor proteina?
mean(proteina)   #Qual o valor medio de proteina?
sd(proteina)     #Qual o desvio padrao de proteina?

#Acessando partes dos vetores
proteina[2]  #Qual o segundo elementos do vetor proteina?
p.arroz[2] #Qual o segundo elementos do vetor arroz?
proteina[2:6]   #Quais os segundo, terceiro, quarto, quinto e sexto elementos no vetor proteina?

#Que cara tem estes dados?

boxplot(proteina~jantinha) #Seu primeiro gr?fico!
boxplot(proteina~jantinha, xlab="Tipo de alimento", ylab="Quantidade de coquinha para ser bom")

#Mas e se eu quiser mudar a ordem para arroz, feijao e brocolis?
#Quais são os níveis do fator jantinha
levels(jantinha)

#Vamos alterar a ordem desses n?veis
jantinha <- factor(jantinha, levels=c("arroz", "feijao", "brocolis"))

boxplot(proteina~jantinha, xlab="Tipo de alimento", ylab="Quantidade de proteina")
boxplot(proteina~jantinha, xlab="Tipo de alimento", ylab="Quantidade de proteina",las=3, boxwex=0.7)
#Veja que o R reordenou os nomes, e deixou os valores correspondentes no lugar certo

## Volta pro ppt

#### Funções ####

help(rep)
?rep

#A ajuda aparece no painel multifuncional inferior direito.

rep(x= 5, times=5)
rep(x= c(5,2), times=5)
rep(x= c(5,2), each=3)
rep(x= c(5,2), length.out=3)

seq(0, 1, length.out = 11)
seq(1, 9, by = 2)
seq(1, 9, by = pi) 

#Ao usar o R para uma análise, você provavelmente usara e criara varios arquivos.
#Isso significa que é sensato criar uma pasta (diretório) para manter 
#todos os arquivos de código juntos. Você pode então configurar o R
#para trabalhar neste diretório, para que os arquivos sejam fáceis
#de encontrar e executar - este será o seu diretório de trabalho. 
#Então agora faça o seguinte:

#Crie um diretório chamado DisciplinaR_UNICAMP em um local apropriado em C:, algum #lugar que você consiga se lembrar!
#Crie subdiretórios dentro de DisciplinaR_UNICAMP chamados: Código, Dados e Resultados
setwd("C:/Users/dema_/OneDrive/UNICAMP/Disciplinas/DisciplinaR_UNICAMP/Codigo/")
dir()



#Observe que o caminho C:/Users/dema_/OneDrive/UNICAMP/Disciplinas/DisciplinaR_UNICAMP/Codigo/
#não deve ser tomado literalmente e 
#inserido! Por exemplo, se você criou DisciplinaR_UNICAMP diretamente em C:,
#usaria setwd ("C:/ DisciplinaR_UNICAMP / Code")
#Observe também que o R lê a barra invertida ( / ) 
#enquanto o Windows lê a barra deitada ( \ )

dado<- read.csv("")