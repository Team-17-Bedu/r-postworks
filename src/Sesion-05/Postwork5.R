# Titulo    : Postwork Sesion 4
# Objetivo  : - Investigar la dependencia o independecia de
#               las variables aleatorias X y Y, el número de
#               goles anotados por el equipo de casa y el número
#               de goles anotados por el equipo visitante.
# Creado por: Elias Farias Abraham
#             Ivan Montiel Cardona
#             Tostado Blazquez Raul
#             Viveros Sánchez Alejandro


# 1.-A partir del conjunto de datos de soccer de la liga española 
# de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data 
# frame SmallData, que contenga las columnas date, home.team, 
# home.score, away.team y away.score; esto lo puede hacer con 
# ayuda de la función select del paquete dplyr. Luego establece un 
# directorio de trabajo y con ayuda de la función write.csv guarda 
# el data frame como un archivo csv con nombre soccer.csv. Puedes 
 #colocar como argumento row.names = FALSE en write.csv.

# Primero se instala la librería dplyr en caso de no tenerla y
# posteriormente se hace lectura de la misma.

# Establecemos el directorio de trabajo
setwd("C:/Users/Raul/Desktop/BEDU/Sesion5/Sesion5/Postwork5")

install.packages("dplyr") #Opcional
library(dplyr) #Cargar la libería

# Almacenamos los los links en  variable para facilitar su manejo
dataurl1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
dataurl1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
dataurl1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"


# Descargamos los datasets
download.file(dataurl1718, destfile = "dataurl1718.csv", mode = "wb")
download.file(dataurl1819, destfile = "dataurl1819.csv", mode = "wb")
download.file(dataurl1920, destfile = "dataurl1920.csv", mode = "wb")

# Se hace lectura de los archivos descargados con el comando lapply
SmallData <- lapply(list.files(pattern ="*.csv"), read.csv)

# Seleccionamos las columnas requeridas
SmallData <- lapply(SmallData,select,Date, HomeTeam, FTHG, AwayTeam ,FTAG)
# Se observa la estructura del DataFrame
head(SmallData)

# Combinamos los Datasets
SmallData <- do.call(rbind, SmallData)
str(SmallData) # Validamos la estructura de la información

# Ajuste del nombre de las comunas
SmallData <- mutate(SmallData, Date = as.Date(Date, "%d/%m/%y"),
               home.team = HomeTeam, 
               home.score = FTHG, away.team = AwayTeam, 
               away.score = FTAG)

# En este caso llegamos a tener valores duplicados, por lo cual 
#procedemos a hacer limpieza de la información
SmallData <- select(SmallData, -HomeTeam, - FTHG, -AwayTeam, -FTAG)
str(SmallData) # Validamos la estructura de la información

# Salvamos el DataFrame en un archivo CSV
write.csv(SmallData, file = 'soccer.csv', row.names = FALSE)


# ***********************************************************************

# 2.- Con la función create.fbRanks.dataframes del paquete fbRanks 
# importe el archivo soccer.csv a R y al mismo tiempo asignelo a una 
# variable llamada listasoccer. Se creará una lista con los elementos
# scores y teams que son data frames listos para la función rank.teams.
# Asigna estos data frames a variables llamadas anotaciones y equipos.

# Nos aseguramos de tener instalado el paquete
install.packages("fbRanks")
# Librería de apoyo
library("fbRanks")
library("dplyr")

# Importar el archivo soccer.csv
listasoccer <- create.fbRanks.dataframes(scores.file = 
"C:/Users/Raul/Desktop/BEDU/Sesion5/Sesion5/Postwork5/soccer.csv")

# Asignar dataframes a variables
anotaciones <- listasoccer$scores
anotaciones <- mutate(anotaciones, date = as.Date(date, "%d/%m/%y"))

# Para equipos nos regresaba un valor nulo, por lo cual se creo mediante
# un conteo el dataframe
equipos <- data.frame(unique(listasoccer$scores$home.team))
equipos <- rename(equipos, name = unique.listasoccer.scores.home.team.)

# Validamos que los valores sean correctos
head(anotaciones)
head(equipos)


#*************************************************************************

# 3.- Con ayuda de la función unique crea un vector de fechas (fecha) 
# que no se repitan y que correspondan a las fechas en las que se 
# jugaron partidos. Crea una variable llamada n que contenga el
# número de fechas diferentes. Posteriormente, con la función 
# rank.teams y usando como argumentos los data frames anotaciones
# y equipos, crea un ranking de equipos usando unicamente datos desde
# la fecha inicial y hasta la penúltima fecha en la que se jugaron 
# partidos, estas fechas las deberá especificar en max.date y min.date. 
# Guarda los resultados con el nombre ranking.

# Convertimos a tipo Date
TestFechas <- as.Date(SmallData$Date, '%d/%m/%Y')
# Eliminamos valores repetidos
TestFechas <- unique(TestFechas)
# Ordenamos para validar que no quedaron valores repetidos
TestFechas <- sort(TestFechas)
# Asignamos a variable n
n <- length(TestFechas)
# Validamos conteo n y fehas
str(TestFechas)
n

#Ranking de equipos
rank.teams(anotaciones,equipos)
#Ranking por equipos con fechas personalizadas
ranking <- rank.teams(anotaciones, teams = equipos, 
                      max.date = TestFechas[n-1], min.date = TestFechas[1], 
                      date.format = '%d/%m/%Y')
#*************************************************************************
# 4.- Finalmente estima las probabilidades de los eventos, el equipo de 
# casa gana, el equipo visitante gana o el resultado es un empate para
# los partidos que se jugaron en la última fecha del vector de fechas 
# fecha. Esto lo puedes hacer con ayuda de la función predict y 
# usando como argumentos ranking y fecha[n] que deberá especificar en date.

#Para partidos jugados el 23 de diciembre de 2020
predict(ranking, date = TestFechas[n])




