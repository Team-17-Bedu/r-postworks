

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 5</strong></h4>
  <p align="center">
     Regresión lineal y clasificación
    <br />
    <a href="Postwork5.R"><strong>Explora el código »</strong></a>
    <br/>
    <br/>
  </p>
  
</p>

## Objetivos
- Continuar con el desarrollo de los postworks; en esta ocasión se utiliza la función predict para realizar predicciones de los resultados de partidos para una fecha determinada
## Requisitos
- R Studio | PyCharm
- R
## Descripcion
1. A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame `SmallData`, que contenga las columnas `date`, `home.team`, `home.score`, `away.team` y `away.score`; esto lo puede hacer con ayuda de la función `select` del paquete `dplyr`. Luego establece un directorio de trabajo y con ayuda de la función `write.csv` guarda el data frame como un archivo csv con nombre *soccer.csv*. Puedes colocar como argumento `row.names = FALSE` en `write.csv`. 

2. Con la función `create.fbRanks.dataframes` del paquete `fbRanks` importe el archivo *soccer.csv* a `R` y al mismo tiempo asignelo a una variable llamada `listasoccer`. Se creará una lista con los elementos `scores` y `teams` que son data frames listos para la función `rank.teams`. Asigna estos data frames a variables llamadas `anotaciones` y `equipos`.


3. Con ayuda de la función `unique` crea un vector de fechas (`fecha`) que no se repitan y que correspondan a las fechas en las que se jugaron partidos. Crea una variable llamada `n` que contenga el número de fechas diferentes. Posteriormente, con la función `rank.teams` y usando como argumentos los data frames `anotaciones` y `equipos`, crea un ranking de equipos usando unicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas las deberá especificar en `max.date` y `min.date`. Guarda los resultados con el nombre `ranking`.


4. Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se jugaron en la última fecha del vector de fechas `fecha`. Esto lo puedes hacer con ayuda de la función `predict` y usando como argumentos `ranking` y `fecha[n]` que deberá especificar en `date`.
## Solucion

Se almacenan los enlaces a los archivos

```r
# Almacenamos los los links en  variable para facilitar su manejo
dataurl1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
dataurl1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
dataurl1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
````

Se descargan los datasets

```r
# Descargamos los datasets
download.file(dataurl1718, destfile = "dataurl1718.csv", mode = "wb")
download.file(dataurl1819, destfile = "dataurl1819.csv", mode = "wb")
download.file(dataurl1920, destfile = "dataurl1920.csv", mode = "wb")
```

### - _Punto 1_
```r
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
```

### - _Punto 2_
```r
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
```


### - _Punto 3_
```r
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
```

### - _Punto 4_
```r
predict(ranking, date = TestFechas[n])
```

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/postwork8-captura1.PNG" alt="predición">
  </a>
</p>
