#### R Mapas ###
#### WD e pacotes #### 
rm(list = ls()) #limpa tudo
setwd("C:\\...\\Codigo") 

install.packages("tidyverse") # coloquem os nomes dos pacotes aqui para instalar

library(ggplot2)       # fazer os gráficos
library(tidyverse)     # Todo o universo tidyverse
library(ggmap)         # ferramentas de mapas para o ggplot2
library(ggthemes)      # temas de fundo dos gráficos 
library(maps)          # ferramentas de mapas gerais
library(raster)        # trabalhar com arquivos raster
library(rgdal)         # Geospatial Data Abstraction Library (ver abaixo)
library(rgbif)         # interação com a base de dados do GBIF
library(sf)            # trabalhar com arquivos shape files
library(rnaturalearth) # acessar o Natural Earth, ver abaixo
library(sp)            # reprojetar dados espaciais 

# O site Natural Earth https://www.naturalearthdata.com/ oferece vários mapas "de fundo" que são bem úteis no dia a dia. Além de oferecer vários shape files de fronteiras de países, estados, do oceano, etc. 
# Baixem o mapa NE1_LR_LC_SR_W.tif do Google Drive, ou do site https://www.naturalearthdata.com/downloads/10m-raster-data/10m-natural-earth-1/, escolham o "Natural Earth I with Shaded Relief, Water, and Drainages" (o último da lista) e baixem o arquivo em resolução média (Download Medium Size)
# Guardo algumas dessas bases de dados do Natural Earth nos Meus Documentos, numa pastinha chamada 'GIS databases', ou seja, bases de dados de SIG (Sistema Informação Geográfica). Sempre bom ter à disposição na hora de fazer uns mapas 
# Não são arquivos pequenos (contém o planeta todo!), e a conexão do site deles é meio lenta. Então ficar baixando custa às vezes bastante tempo e é melhor ter no PC!
# GDAL- Geospatial Data Abstraction Library. É uma biblioteca de software para leitura e gravação de formatos de dados geoespaciais (raster e vetor/shape) de código aberto. 

#### Fazendo nosso próprio mapa ####
### Começar com um mapa de fundo tipo RASTER baixado do site Natural Earth
# Arquivo em formato geoTiff. 
# TIFF é um formato de imagem (ex: bitmap, JPEG, GIF) em raster, ou seja, contém pixels.
# Em um TIFF, os pixels podem conter informação ou cor (cor é informação!) e inclusive ter várias camadas de informação por pixel (precipitação, temperatura, umidade, etc.)! 
# Mas uma imagem com mais de uma informação por pixel, como assim? 
# Lembram que uma cor tem três canais de informação: RGB)? 
# Pensem em um TIFF como uma imagem com ainda mais canais de cores! São suas camadas de informação...

GDALinfo("../Dados/NE1_LR_LC_SR_W.tif")
nat_earth <- stack("../Dados/NE1_LR_LC_SR_W.tif")

# Um stack é um arquivo tipo raster que tem mais de um canal de informações por pixel, por pixel uma pilha de informações (pilha = stack em inglês)
# Aqui temos um stack de três canais de cores, o RGB. Na coluna "names" estão esses canais: red = NE1_LR_LC_SR_W.1, green = NE1_LR_LC_SR_W.2, blue = NE1_LR_LC_SR_W.3 
# Rodando só o objeto abre os metadados desse objeto, as informações gerais.
nat_earth

# Vamos recortar uma parte dos dados, pra não ter que trabalhar com o planeta inteiro!
# Primeiro definimos uma área de interesse. No caso é uma "janela" (norte, sul, leste, oeste) que engloba aproximadamente o Tocantins. 

south <- -30.5
north <-  30.5
east  <- -45.5
west  <- -52

# Usaremos a janela para recortar, fazer um crop, do mapa original usando a função crop() do pacote raster
nat_earth_crop <- crop(nat_earth, c(west, east, south, north))
# O que mudou nos meta dados?
nat_earth_crop

# Podemos fazer uma plotagem simples desses dados com plotRGB() do pacote raster
# Lembrando que as cores estão nos "names" (NE1_LR_LC_SR_W.1, NE1_LR_LC_SR_W.2, NE1_LR_LC_SR_W.3) e a função plotRGB extrai de lá os valores.
plotRGB(nat_earth_crop, r=1, g=2, b=3, colNA='white')

# Vamos remover o nat_earth original, pois ele contém dados de todo o planeta. 
# Mantê-lo como objeto consome bastante memória e não vamos mais usá-lo
rm(nat_earth)

# Os próximos gráficos serão feitos usando o pacote ggplot2. Ele é para gráficos, mas também permite plotar mapas (que em essência são também gráficos)
# Para mais informação sobre a sintaxe do pacote, refira à aula sobre ggplot2
# Para acessar os dados e fazer gráficos usando o ggplot2 precisamos transformar os dados "raster" em um dataframe (pacote raster)

nat_earth_df <- as.data.frame(nat_earth_crop, xy = TRUE)
str(nat_earth_df) # para ver a estrutura do novo dataframe

# Temos 5 colunas, x e y para as coordenadas, e três canais de cores.
# Precisamos criar uma coluna dos valores de cor que combine os três canais. 
# Lembrem que cada cor é composta de três canais (Red, Green, Blue)
# nat_earth_df tem três colunas que indicam cada um dos canais. 
# red = "NE1_LR_LC_SR_W.1", green = "..SR_W.2", blue =  "..SR_W.3"
# Podemos expressar as cores em códido hexadecimal (código html), lembram?
# São aqueles códigos com um # seguido de seis numeros ou letras (ex: "#B2CCB0"). 
# A função rgb cria códigos hexadecimais usando os níveis de cada canal (que aqui extraímos do dataframe com intexação)

nat_earth_df$rgb <- rgb(red = nat_earth_df$NE1_LR_LC_SR_W.1,
                        green = nat_earth_df$NE1_LR_LC_SR_W.2, 
                        blue = nat_earth_df$NE1_LR_LC_SR_W.3,
                        maxColorValue = 255)
head(nat_earth_df)
# Agora temos um dataframe com os valores de cor para cada ponto x e y no raster. 
# Podemo já fazer um mapa, similar ao do plotRGB() lá em cima
# Primeiro chamamos os dados dentro da função ggplot (com o data = ),
# e definimos nossos parametros estéticos (aes == aesthetics): 
# qual coluna é o eixo x = x, qual o y = y
# e qual contém a cor de preenchimento (fill = rgb).
# Com os objetos que começam com "geom_" vamos adicionando camadas de objetos geométricos (pontos, linhas, poligonos, pixels, etc.) ao gráfico.
# Como temos uma imagem em raster, vamos usar o geom_raster

ggplot(data = nat_earth_df, aes(x = x, y = y, fill = rgb)) +
  geom_raster() +                   # adiciona camada raster
  coord_sf(xlim = c(west, east),    # limites do eixo x (igual que o crop)
           ylim = c(south,north)) + # limites do eixo y 
  scale_fill_identity() +           # usa código em $rgb p/ dar cor de preenchimento
  theme_map() # ggplot usa temas (veja abaixo)

# Sobre temas: temas contém definições das configurações de fundo, eixos, etc. 
# Podemos ajustar de tudo, mas aqui o tema predefinido chamado "theme_map" resulta em um mapa bem limpo. Tente mudar para theme_classic() para ver a diferença

### Vamos adicionar shapefiles/ vetores das fronteiras dos estados?

# Usando a função ne_states do pacote naturalearth, podemos baixar as fronteiras dos países e das unidades administrativas (os estados). 

# Primeiro baixamos um mapa do Brazil com todos estados ("sf" = shape file)
br_map <- ne_states(country = "Brazil", returnclass = "sf") 
# dele fazemos um subset do mapa do estado do Tocantins usando subset()
to_map <- subset(br_map, br_map$name == "Tocantins")
# Também faremos um subset dos estados que não são o TO, abaixo o porquê
no_to_map <- subset(br_map, br_map$name != "Tocantins")

## Vamos ver como ficou? 
# O geom_sf adiciona objetos geométricos tipo sf (shapefile)

ggplot() +
  geom_sf(data = br_map, fill = "white") + # mapa do brasil em branco
  geom_sf(data = to_map, fill = "grey") +  # mapa do Tocantins em cinza
  theme_map()

# E se quisermos fazer uma visualização só da nossa área de estudo (aquela que definimos lá em cima com o crop)?
# A função para fazer um corte (crop) de um raster e de um shapefile é diferente
# Para o shapefile em formato "sf" usamos a função st_crop,
# mas usamos as mesmas coordenadas definidas nos objetos north, south, east, west. 
# Faremos isso para o mapa dos estados que não são o Tocantins (mas funciona igual para os outros shapefiles)

no_to_map_crop <- st_crop(x = no_to_map, 
                          xmin = west, 
                          ymin = south, 
                          xmax = east, 
                          ymax = north)

# Vamos juntar tudo? Faremos um mapa que tem como imagem de fundo o natural earth landcover 
# por cima dele plotaremos os estados que não são o TO
# daremos a eles um preenchimento branco  semi-transparente (usando o alpha = 0.5). # Assim o TO fica transparente! Isso destaca a nossa área de interesse.
# Adicionaremos o ponto de estudo no norte do TO que apareceu na apresentação.
# Finalmente, definimos os limites do gráfico.

ggplot() +
  geom_raster(data = nat_earth_df , aes(x = x, y = y, fill = rgb))+ 
  geom_sf(data = no_to_map_crop,         # fonte dos dados == não TO
          aes(fill = "white"),           # preenchimento branco
          alpha = 0.5) +                 # transparência 50%
  geom_point(aes(y = -7.20, x = -47.75), # nosso ponto (coords em WGS84) 
             col = "red", size = 2) +    # cor vermelho, tamanho 2
  coord_sf(xlim = c(west, east),         # limites x (usando objetos west + east)
           ylim = c(south,north))+       # limites y
  scale_fill_identity() +                # cor preenchimento em $rgb
  theme_map()

# Já fica bonitinho né? Dá pra ir adicionando mais coisas, eternaente!
# Dá pra juntar as duas figuras (mapa do Brazil que mostra o TO + mapa do TO)
# Para isso vejam as aulas de ggplot2

# Eu achei as cores do gráfico um pouco "pálidas" e resolvi tentar escurecer
# usando a função stretch, podemos esticar o universo RGB que temos
# Dentro de cada canal em nat_earth_crop, os valores de RGB estão entre 0 e 255.
# vejam os "min values" e "max values" rodando só o objeto

nat_earth_crop

# Dá pra ver que pro canal vermelho, os valores vão de 131 até 250, pra verde de 154 a 246 e azul de 130 até 225. Certo?
# Olhando para os três canais juntos, o valor mínimo é de 130 e o máximo é de 250. 
# Isso quer dizer que não tem valores nenhum de informação de zero a 130.
# Dá pra vizualizar isso em um histograma:

dev.off() # Limpa os gráficos e todos parâmetros
hist(nat_earth_df$NE1_LR_LC_SR_W.1, xlim = c(0,255), col = "red")

# E se ao invés de usarmos 0 e 255 como os valores máximos de cada canal, "reprojetarmos" a distribuição das cores usando o máximo e mínimo dos três canais (ou seja esticar os valores entre 130 e 250 para uma nova escala de 0 a 255)
# Para esticar valores usasmos a função stretch (significa esticar em inglês)
# Ela tem que ser aplicada em um objeto do tipo raster, então em nat_earth_crop

ne_stretch <- stretch(x = nat_earth_crop, 
                      minv=0, maxv=255, 
                      smin=130, 
                      smax=250)

# Aí passamos essa nova base de dados para dataframe 
ne_stretch_df <- as.data.frame(ne_stretch)
# Notem que ela só tem as três colunas das cores! 
str(ne_stretch_df)
# Vamos ver como ficou a distribuição dos valores (entre 0 e 255) no canal vermelho
hist(ne_stretch_df$NE1_LR_LC_SR_W.1, xlim = c(0,255), col = "red")
# Não estão mais "enfiadas em um canto", certo? 
# Agora podemos usar essas colunas no novo dataframe pra recalcular os códigos de cores hexadecimais. 
# Vamos criar uma nova coluna rgb2 no nosso dataframe original com as novas cores

nat_earth_df$rgb2 <- rgb(red = ne_stretch_df$NE1_LR_LC_SR_W.1,
                         green = ne_stretch_df$NE1_LR_LC_SR_W.2, 
                         blue = ne_stretch_df$NE1_LR_LC_SR_W.3,
                         maxColorValue = 255)
str(nat_earth_df)

# "Esticar" as cores para que cubram melhor o 0 a 255 dos canais de cor aumenta o intensidade / contraste da imagem, pois permite uma maior profundidade (de 0 a 255, ao invés de entre 130 e 250) de valores de cor para cada canal.  
# Vamos ver como ficou? Usamos o mesmo código que acima, mas agora a cor de preenchimento (o fill = ) vem da coluna rgb2!

ggplot() +
  geom_raster(data = nat_earth_df , aes(x = x, y = y, fill = rgb2))+ 
  geom_sf(data = no_to_map_crop,         # fonte dos dados == não TO
          aes(fill = "white"),           # preenchimento branco
          alpha = 0.5) +                 # transparência 50%
  geom_point(aes(y = -7.20, x = -47.75), # nosso ponto (em WGS84) 
             col = "red", size = 2) +    # cor vermelho, tamanho 2
  coord_sf(xlim = c(west, east),         # limites x (usando objetos west + east)
           ylim = c(south,north))+       # limites y
  scale_fill_identity() +                # cor preenchimento em $rgb
  theme_map()

# WOW!

#### GBIF data - Euterpe ####

euterpe <- occ_data(scientificName = "Euterpe edulis", hasCoordinate = T)
euterpe <- SpatialPoints(cbind(euterpe$data$decimalLongitude,euterpe$data$decimalLatitude))
euterpe <- as.data.frame(euterpe)
colnames(euterpe) <- c("lon", "lat")
head(euterpe)

south <- -36
north <-  8
east  <- -32
west  <- -76

ggplot() +
  geom_sf(data = br_map,    fill = "white") + # mapa do brasil em branco
  geom_point(data = euterpe, aes(x = lon, y = lat), col = "red") +
  coord_sf(xlim = c(west, east),         # limites x (usando objetos west + east)
           ylim = c(south,north))+       # limites y
  geom_hline(yintercept = 0, linetype = "dashed") +
  theme_map()

#### Mapa com dados próprios no R ####

geo   <- read.table("../Dados/geo_sp.txt",header=TRUE,sep="\t")
str(geo)
unique(geo$species)

# Criar uma "caixa" de coordenadas
south <- -36
north <-  8
east  <- -32
west  <- -76

loc   <- c(west, south, east, north)

map <- get_stamenmap(bbox = loc, zoom = 5, maptype = c("terrain-background"))

ggmap(map)+
  geom_point(aes(x = lon, y = lat, col = genus), data = geo)+
  scale_color_manual(values = c( "dodgerblue4", "firebrick4"))+
  theme_map()

## Tá legal! Mas quero mais!! 
# Coordenadas mais aproximadas

north <- 0
south <- -16
east  <- -33
west  <- -50
loc2   <- c(west, south, east, north)

map2 <- get_stamenmap(bbox = loc2, zoom = 6, maptype = c("toner-lite"))
# Agora um mapa com as distribuições dos pontos, mas também uma interpolação da densidade de pontos por cada localidade. Seria uma visualização em duas dimensões de um histograma de densidade ou plot de densidade (Kernel density plot) que já fizemos durante as aulas

ggmap(map2)+
  geom_density_2d(aes(x = lon, y = lat, col = genus), data = geo)+ 
  stat_density_2d(geom = "polygon", aes(alpha = (..level..) ^ 2, fill = genus), data = geo) +
  geom_point(aes(x = lon, y = lat, col = genus), data = geo)+
  scale_color_manual(name = "Genus", values = c( "dodgerblue4", "firebrick4")) +
  scale_fill_manual(name = "Genus", values = c( "dodgerblue4", "firebrick4"))+
  theme_map()

#### Extrair dados climáticos a partir de lat lon ####
# A função getData acessa bases de dados com dados globais 
# No caso estamos acessando os dados "bio" do WorldClim (são 19 dados diferentes relacionados à clima, ver lista no final do script), mas tem de tudo! 

BClim <- getData('worldclim', var='bio', res=5)
geo2  <- geo 
coordinates(geo2) <- ~ lon + lat
clim <- data.frame(extract(BClim, geo2)) #Extrair os valores

plot(BClim$bio1/10, xlim = c(west, east), ylim = c(south, north), main = "Temperature")
plot(BClim$bio12, xlim = c(west, east), ylim = c(south, north), main = "Precipitation")

geo$prec <- clim$bio12
geo$temp <- clim$bio1/10

head(geo)

## Gráficos dos dados extraídos do mapa
# Para precipitação
ggplot(geo, aes(x=genus, y = prec, fill = genus))+
  geom_jitter(col="grey88")+
  geom_violin(trim = F, alpha = 0.5)+
  labs(x= "Species", y= "Precipitation")+
  theme_classic()+
  scale_fill_manual(name = "Genus", values = c( "dodgerblue4", "firebrick4"))

# Para temperatura
ggplot(geo, aes(x=genus, y = temp, fill = genus))+
  geom_jitter(col="grey88")+
  geom_violin(trim = F, alpha = 0.5)+
  labs(x= "Species", y= "Temperature")+
  theme_classic()+
  scale_fill_manual(name = "Genus", values = c( "dodgerblue4", "firebrick4"))

# Podemos testar se os dois envelopes climáticos são diferentes
t_prec <- lm(prec~genus, data = geo)
summary(t_prec)

# O valor de p é bem baixo (2e-16)
# Mas a distribuição dos dados não aparenta ser normal, muito pelo contrário, vejam o formado do "violino", tem muito mais dados para um lado que para o outro. 
# Vamos ver se os resíduos do teste tem distribuição normal?
# Usaremos um plot de densidade de distribuição dos pontos (invés de um histograma)
plot(density(residuals(t_prec))) 
# Com um QQ plot já podemos ver que os pontos não ficam perto da linha qq
# Tem um cauda grande nos pontos que dá esses valores que sobem e deixam de acompanhar a linha:
qqnorm(resid(t_prec))
qqline(resid(t_prec)) 
# Quer um teste formal? Fazemos um teste de normalidade Shapiro-Wilk
# Notar que esse teste é sensível ao n. Se temos muitas observações, ainda que se comportem bem dentro da normalidade, o teste tende a retornar um p significativo, avisando que a distribuição não é normal. Não só focar no teste em sí, o "teste" visual ajuda bastante nessas horas.
shapiro.test(resid(t_prec))

#### Pacote brazilmaps ####

library(brazilmaps)
# Parece ser um pacote interessante. A dificuldade é ter que procurar os códigos IBGE pra cada estado, municipio, etc. quando precisar. 
# https://www.ibge.gov.br/explica/codigos-dos-municipios.php
# Um "problema" do pacote é que usa uma projeção diferente (GRS80) que o "padrão" WGS84 (EPSG:4326) 
# Portanto, combinar com dados próprios (de GPS por exemplo) requer cuidado!

sp <- get_brmap(geo = "State", geo.filter = list(State = 35), class = "sf")
plot_brmap(sp)

# Only displaying the microregions of the state of Sao Paulo
map_sp_micro <- get_brmap(geo = "MicroRegion", geo.filter = list(State = 35), class = "SpatialPolygonsDataFrame")
plot_brmap(map_sp_micro)

sp_cities_map <- get_brmap(geo = "City", geo.filter = list(State = 35), class = "sf")
plot_brmap(sp_cities_map)

pop     <- pop2017[pop2017$mun %in% unique(sp_cities_map$City),]
colnames(pop) <- c("City","nome_mun","pop2017")
pop$log_pop <- log(pop$pop2017)

plot_brmap(sp_cities_map,
           data_to_join = pop,
           join_by = c("City"),
           var = "log_pop") +
  labs(title = "População por Municipio 2017 - São Paulo")+
  scale_fill_continuous(type = "viridis")

#### Pacote geobr ####
library(geobr)

# Parece ser um pacote interessante. Aqui algund exemplos copiados descaradamente do site do pacote (adaptei um pouco). 
# Um "problema do pacote é que usa uma projeção diferente que o "padrão" WGS84 (EPSG: 4326) 
# Portanto, combinar com dados próprios (de GPS por exemplo) requer cuidado!

# Municipality of Sao Paulo
muni <- read_municipality(code_muni = 3550308, year=2010 )
muni # Veja a projeção em proj4string
plot(muni[muni$code_muni==1])

# All municipalities in the state of Alagoas
muni <- read_municipality(code_muni= "AL", year=2007)
plot(muni[muni$code_muni==1])

# Remove plot axis
no_axis <- theme(axis.title=element_blank(),
                 axis.text=element_blank(),
                 axis.ticks=element_blank())

# Plot all Brazilian states
states <- read_state(year=2014)

ggplot() +
  geom_sf(data=states, fill="grey88", color="firebrick2", 
          size=.15, show.legend = T) +
  labs(subtitle="States", size=8) +
  theme_minimal()+
  no_axis

# download Life Expectancy data
install.packages("rio")
library(rio)

adh <- rio::import("http://atlasbrasil.org.br/2013/data/rawData/Indicadores%20Atlas%20-%20RADAR%20IDHM.xlsx", which = "Dados")

# keep only information for the year 2014 and the columns we want
adh <- subset(adh, ANO == 2014)

# join the databases
states <-left_join(states, adh, by = c("abbrev_state" = "NOME_AGREGA"))

ggplot() +
  geom_sf(data=states, aes(fill=ESPVIDA), color= NA, size=.15) +
  labs(subtitle="Life Expectancy at birth, Brazilian States, 2014", size=8) +
  scale_fill_distiller(palette = "Blues", 
                       name="Life Expectancy", 
                       limits = c(65,80)) +
  theme_map() 

#### Lista das variáveis do worldclim #### 
#BIO1 = Annual Mean Temperature
#BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
#BIO3 = Isothermality (BIO2/BIO7) (* 100)
#BIO4 = Temperature Seasonality (standard deviation *100)
#BIO5 = Max Temperature of Warmest Month
#BIO6 = Min Temperature of Coldest Month
#BIO7 = Temperature Annual Range (BIO5-BIO6)
#BIO8 = Mean Temperature of Wettest Quarter
#BIO9 = Mean Temperature of Driest Quarter
#BIO10 = Mean Temperature of Warmest Quarter
#BIO11 = Mean Temperature of Coldest Quarter
#BIO12 = Annual Precipitation
#BIO13 = Precipitation of Wettest Month
#BIO14 = Precipitation of Driest Month
#BIO15 = Precipitation Seasonality (Coefficient of Variation)
#BIO16 = Precipitation of Wettest Quarter
#BIO17 = Precipitation of Driest Quarter
#BIO18 = Precipitation of Warmest Quarter
#BIO19 = Precipitation of Coldest Quarter 

#### Outras fontes ####

# Instruções para fazer mapas bonitos com topografia:
#   https://stanford.edu/~vbauer/teaching/hillshade.html
# Tem como trabalhar com dados de elevação de terreno? SIM!
#   https://cran.r-project.org/web/packages/elevatr/vignettes/introduction_to_elevatr.html
