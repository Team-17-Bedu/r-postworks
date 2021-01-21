#postowork sesion 1
library(dplyr)
library(janitor)
install.packages("tidyr")
library(tidyr)


setwd("C:/Users/abraham/Documents/DATASCIENCE/2daetapa/postwork/r-postworks/src/1erpostworked/dataset")

Futbol <-"https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = Futbol, destfile = "SP1.csv", mode = "wb")

data <- read.csv("SP1.csv")
#dejamos la columna de goles visitantes y de locales 
datagoles<-data[,c('FTHG','FTAG')]

#obtener el total de datos 
total_datos<-length(datagoles$FTHG)

#Tabla de frecuencia de los locales 
TF_locales<-datagoles%>%group_by(FTHG)%>%summarise(frequency=n())

#Tabla de frecuencia de los visitanters 
TF_visitantes<-datagoles%>%group_by(FTAG)%>%summarise(frequency=n())

#probabilidad de los locales marginal 
probabilidad_marginal_local<-TF_locales$frequency /total_datos

#probabiliad de los visitantes marginal 
probabilidad_marginal_visitantes<-TF_visitantes$frequency/total_datos

#creamos la tabla de los locales con su frecuencia y probabilidad 
TablaLocales<-data.frame(TF_locales,probabilidad_marginal_local)
TablaLocales$NGoles=TablaLocales$FTHG
#creamos la tabla de los visitantes con su frecuencia y probabilidad 
TablaVisitantes<-data.frame(TF_visitantes,probabilidad_marginal_visitantes)
TablaVisitantes$NGoles=TablaVisitantes$FTAG

#se agrega nueva linea para que la tabla de visitantes tenga los mismos tamaños y no exista problema al poder hacer alguna operacion
nuevalinea=data.frame(FTAG=c(0),frequency=c(0),probabilidad_marginal_visitantes=c(0),NGoles=c(6))
TablaVisitantes=rbind(TablaVisitantes,nuevalinea)

#unimos las dos tablas creadas anteriormente para poder sacar la probabilidad conjunta 
#newtable<-merge(TablaLocales,TablaVisitantes,by="NGoles",all.x = TRUE,)
#newtable$sum_probabilidades=TablaLocales$probabilidad_marginal_local+TablaVisitantes$probabilidad_marginal_visitantes
#newtable$sum_frecuencia=TablaLocales$frequency+TablaVisitantes$frequency


#prueba ver que sucede 
tabla_conjunta <- unite(datagoles,Goles,c(1:2),  sep = " ", remove = TRUE)
tablaConjunta_frecuencia <-tabla_conjunta %>%group_by(Goles) %>% summarise(frequency = n())

#sacar probabilidad conjunta 
tablacojunta_probabilidad <- tablaConjunta_frecuencia$frequency / total_datos

TablaFinal <- data.frame(tablaConjunta_frecuencia,tablacojunta_probabilidad)
