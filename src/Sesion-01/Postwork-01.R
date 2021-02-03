# Titulo    : Postwork Sesion 1
# Objetivo  : El Postwork tiene como objetivo que practiques los comandos básicos aprendidos durante la sesión, de tal modo que sirvan para reafirmar el conocimiento.
# Creado por: 
# Elias Farias Abraham 
# Montiel Cardona Iván
#Tostado Blazquez Raul
#Viveros Sánchez Alejandro

library(dplyr)
library(janitor)
install.packages("tidyr")
library(tidyr)


# Asignación dinamica de espacio de trabajo
dir <- paste0(getwd(), "/src/Sesion-01/datasets")
setwd(dir)

Futbol <-"https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = Futbol, destfile = "SP1.csv", mode = "wb")

data <- read.csv("SP1.csv")
# Dejamos la columna de goles visitantes y de locales
datagoles<-data[,c('FTHG','FTAG')]

# Obtener el total de datos
total_datos<-length(datagoles$FTHG)

# Tabla de frecuencia de los locales
TF_locales<-datagoles%>%group_by(FTHG)%>%summarise(frequency=n())

# Tabla de frecuencia de los visitanters
TF_visitantes<-datagoles%>%group_by(FTAG)%>%summarise(frequency=n())

# Probabilidad de los locales marginal
probabilidad_marginal_local<-TF_locales$frequency /total_datos

# Probabiliad de los visitantes marginal
probabilidad_marginal_visitantes<-TF_visitantes$frequency/total_datos

# Creamos la tabla de los locales con su frecuencia y probabilidad
TablaLocales<-data.frame(TF_locales,probabilidad_marginal_local)
TablaLocales$NGoles=TablaLocales$FTHG

# Creamos la tabla de los visitantes con su frecuencia y probabilidad
TablaVisitantes<-data.frame(TF_visitantes,probabilidad_marginal_visitantes)
TablaVisitantes$NGoles=TablaVisitantes$FTAG


# Creacion de tabla de frecuencia conjunta 
tabla_conjunta <- unite(datagoles,Goles,c(1:2),  sep = " ", remove = TRUE)
tablaConjunta_frecuencia <-tabla_conjunta %>%group_by(Goles) %>% summarise(frequency = n())

# Sacar probabilidad conjunta
tablacojunta_probabilidad <- tablaConjunta_frecuencia$frequency / total_datos

TablaFinal <- data.frame(tablaConjunta_frecuencia,tablacojunta_probabilidad)
