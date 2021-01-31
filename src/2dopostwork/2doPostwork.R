#postwork sesion 2 

#se llama a la libreria dplyr
library(dplyr)

#fijamos directorio 
setwd("C:/Users/abraham/Documents/DATASCIENCE/2daetapa/postwork/r-postworks/src/2dopostwork/datasets")

#guardamos los links en una variable 
dataurl1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
dataurl1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
dataurl1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"

#descargamos los datasets
download.file(dataurl1718, destfile = "dataurl1718.csv", mode = "wb")
download.file(dataurl1819, destfile = "dataurl1819.csv", mode = "wb")
download.file(dataurl1920, destfile = "dataurl1920.csv", mode = "wb")

#leer los archivos descargados con el comando lapply
lista <- lapply(list.files(pattern ="*.csv"), read.csv)


#2.Obten una mejor idea de las características de los data frames al usar las funciones: str, head, View y summary

#realizamos el segundo punto con el primer dataset de la lista 
str(lista[[1]]); head(lista[[1]]); summary(lista[[1]]); View(lista[[1]])

#realizamos el segundo punto con el segundo dataset de la lista 
str(lista[[1]]); head(lista[[2]]); summary(lista[[2]]); View(lista[[2]])

#realizamos el segundo punto con el tercer dataset de la lista 
str(lista[[3]]); head(lista[[3]]); summary(lista[[3]]); View(lista[[3]])

#3 Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames. (Hint: también puedes usar lapply).

#ejecutamos el comando para poder seleccionar las columnas requeridas el punto 3 
lista <- lapply(lista,select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

#vemos como se ve el primer dataframe
head(lista[1])

#vemos como se ve el segundo dataframe
head(lista[2])

#vemos como se ve el tercer dataframe
head(lista[3])

#4 Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para arreglar las fechas). Con ayuda de la función rbind forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función do.call podría ser utilizada).

#se combina los datasets 
data <- do.call(rbind, lista)

#Se verifica que todos los datos sean igual 
str(data)

#arreglamos las fechas con mutate
data <- mutate(data, Date = as.Date(Date, "%d/%m/%y"))

#vemos como quedaron las fechas 
head(data)


