# Postwork sesion 2
# Objetivo: 
# Importar múltiples archivos csv a R.
# Observar algunas características y manipular los data frames.
# Creado por:
# Elias Farias Abraham 
# Montiel Cardona Iván
#Tostado Blazquez Raul
#Viveros Sánchez Alejandro

# Se llama a la libreria dplyr
library(dplyr)

# Asignación dinamica de espacio de trabajo
dir <- paste0(getwd(), "/src/Sesion-02/datasets")
setwd(dir)

# Guardamos los links en una variable
dataurl1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
dataurl1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
dataurl1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"

# Descargamos los datasets
download.file(dataurl1718, destfile = "dataurl1718.csv", mode = "wb")
download.file(dataurl1819, destfile = "dataurl1819.csv", mode = "wb")
download.file(dataurl1920, destfile = "dataurl1920.csv", mode = "wb")

# Leer los archivos descargados con el comando lapply
lista <- lapply(list.files(pattern ="*.csv"), read.csv)


# 2. Obten una mejor idea de las caracteristicas de los data frames al usar las funciones: str, head, View y summary

# Realizamos el segundo punto con el primer dataset de la lista
str(lista[[1]]); head(lista[[1]]); summary(lista[[1]]); View(lista[[1]])

# Realizamos el segundo punto con el segundo dataset de la lista
str(lista[[1]]); head(lista[[2]]); summary(lista[[2]]); View(lista[[2]])

# Realizamos el segundo punto con el tercer dataset de la lista
str(lista[[3]]); head(lista[[3]]); summary(lista[[3]]); View(lista[[3]])

# 3. Con la funcion select del paquete dplyr selecciona �nicamente las columnas Date,
# HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames.
# (Hint: tambien puedes usar lapply).

# Ejecutamos el comando para poder seleccionar las columnas requeridas el punto 3
lista <- lapply(lista,select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

# Vemos como se ve el primer dataframe
head(lista[1])

# Vemos como se ve el segundo dataframe
head(lista[2])

# Vemos como se ve el tercer dataframe
head(lista[3])

# 4. Asegurate de que los elementos de las columnas correspondientes de los nuevos
# data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para arreglar las fechas).
# Con ayuda de la funcion rbind forma un unico data frame que contenga las seis columnas
# mencionadas en el punto 3 (Hint 2: la funcion do.call podria ser utilizada).

# Se combina los datasets
data <- do.call(rbind, lista)

# Se verifica que todos los datos sean igual
str(data)

# Arreglamos las fechas con mutate
data <- mutate(data, Date = as.Date(Date, "%d/%m/%y"))

# Vemos como quedaron las fechas
head(data)


