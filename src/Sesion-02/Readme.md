

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 2</strong></h4>
  <p align="center">
     Manipulación de datos en R
    <br />
    <a href="Postwork-02.R"><strong>Explora el código »</strong></a>
    <br/>
    <br/>
  </p>
  
</p>

## Objetivos
* Importar múltiples archivos csv a R.

* Observar algunas características y manipular los data frames.

* Combinar múltiples data frames en un único data frame.
## Requisitos
- RStudio | PyCharm
- R

## Descripción
Ahora vamos a generar un cúmulo de datos mayor al que se tenía, esta es una situación habitual que se puede presentar para complementar un análisis, siempre es importante estar revisando las características o tipos de datos que tenemos, por si es necesario realizar alguna transformación en las variables y poder hacer operaciones aritméticas si es el caso, además de sólo tener presente algunas de las variables, no siempre se requiere el uso de todas para ciertos procesamientos:

1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a R, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

2. Obten una mejor idea de las características de los data frames al usar las funciones: `str`, `head`, `View` y `summary`

3. Con la función `select` del paquete dplyr selecciona únicamente las columnas _Date_, _HomeTeam_, _AwayTeam_, _FTHG_, _FTAG_ y _FTR_; esto para cada uno de los data frames. (Hint: también puedes usar `lapply`).

4. Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: usa `as.Date` y mutate para arreglar las fechas). Con ayuda de la función `rbind` forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función `do.call` podría ser utilizada).

## Solución
Instalar librerias requeridas 
```r
install.packages("dplyr")
```
Guardar los links de datasets en variables 
```r
dataurl1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
dataurl1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
dataurl1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
```
Descargar los datasets
```r
download.file(dataurl1718, destfile = "dataurl1718.csv", mode = "wb")
download.file(dataurl1819, destfile = "dataurl1819.csv", mode = "wb")
download.file(dataurl1920, destfile = "dataurl1920.csv", mode = "wb")
```
Leer archivos descargados con el comando lapply 
```r
lista <- lapply(list.files(pattern ="*.csv"), read.csv)
```
Obtener una mejor idea de las características de los data frames al usar las funciones: str, head, View y summary
```r
str(lista[[1]]); head(lista[[1]]); summary(lista[[1]]); View(lista[[1]])
str(lista[[1]]); head(lista[[2]]); summary(lista[[2]]); View(lista[[2]])
str(lista[[3]]); head(lista[[3]]); summary(lista[[3]]); View(lista[[3]])
```

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/sesion2-captura-01.PNG" alt="Summary">
  </a>
</p>

Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames. (Hint: también puedes usar lapply).

```r
lista <- lapply(lista,select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
```

Verificar con un head que se hizo correctamente 
```r
head(lista[1])
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/sesion2-caputra-01.PNG" alt="head dataset1">
  </a>
</p>

 Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para arreglar las fechas). Con ayuda de la función rbind forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función do.call podría ser utilizada).

Se unene los datasets 
```r
data <- do.call(rbind, lista)
```
Se verifica que todos los datos sean igual 

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/sesion2-captura-03.PNG" alt="head dataset1">
  </a>
</p>

Arreglar fechas con el comando mutate 
```r
data <- mutate(data, Date = as.Date(Date, "%d/%m/%y"))
```

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/sesion2-captura-04.PNG" alt="verify number">
  </a>
</p>
