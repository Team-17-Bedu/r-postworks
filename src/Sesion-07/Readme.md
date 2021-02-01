

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 6</strong></h4>
  <p align="center">
     Sesion 7. RStudio Cloud - Github, conexiones con BDs y lectura de datos externos
    <br />
    <a href="https://github.com/begeistert/microcontrollers-ccs-c-compiler"><strong>Explora el código »</strong></a>
    <br/>
    <br/>
  </p>
  
</p>

## Objetivos
- Realizar el alojamiento del fichero de un fichero .csv a una base de datos (BDD), en un local host de Mongodb a traves de _`R`_.

## Requisitos
- R Studio | PyCharm
- R

## Descripción 
Haciendo uso de los conocimiento adquiridos durante la sesión se usara el manejador de BDD _Mongodb Compass_, para realizar una consulta desde _R Studio_.

Importa el conjunto de datos data.csv a `R` y realiza lo siguiente:

1. Alojar el fichero _data.csv_ en una base de datos llamada _match_games_, nombrando al _collection_ como _match_.

2. Una vez hecho esto, realizar un count para conocer el número de registros que se tiene en la base.

3. Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

4. Se graficará la serie de tiempo. Además se agregara las etiquetas describiendo la grafica.

## Solución 

Primero se descargaron las bibliotecas necesarias para la realización del programa. Las escuelas _`dplyr`_ y _`lubridate`_

```r
#Instalacion del paquete "dplyr" para la manipulacion de dataframes.
install.packages("dplyr")
#Instalacion del paquete "lubridate" para la manipulacion de dataframes.
install.packages("lubridate")
```
<br/>

Posteriormente se hicieron uso de las _librerias_  correspondientes:

```r
#Uso de las librerias descargados
library("dplyr")
library("lubridate")
```

### - _Punto 1_

Se cargo el documento _match.data.csv_.

```r
#Cargando documento .csv
data <- read.csv("C:/Users/ordna/OneDrive/Documents/Data_BEDU/Modulo_2/Programacion-con-R-Santander-master/Sesion-06/Postwork/match.data.csv")
```

Posteriormente se ejecuto la linea de codigo:
```r
#Revisando contenido del DataFrame
head(data)
```

<br/>
Con el fin de observar el dataframe ya cargado. Con ello observamos la siguiente tabla:

|index|date      |home.team|home.score|away.team|away.score|
|------|----------|---------|----------|---------|----------|------|
|1     |2010-08-28|Hercules |0         |Ath Bilbao    |1     |
|2     |2010-08-28|Levante  |1         |Sevilla  |4         |      |
|3     |2010-08-28|Malaga   |1         |Valencia |3         |      |
|4     |2010-08-29|Espanol  |3         |Getafe   |1         |      |
|5     |2010-08-29|La Coruna  |0        |Zaragoza  |0     |
|6     |2010-08-29|Mallorca |0         |Real Madrid    |0     |

Seguidamente se le agrego un nuemo campo al DataFrame llamado _`sumagoles`_. Se aneo con la siguiente linea de codigo:
```r
#El resultado sera la suma de goles del equipo visitante más los del equipo local
data$sumagoles <- data$home.score + data$away.score
```

### - _Punto 2_

Para obtener el punto dos se agrego dos campos nuevos; _`mes`_ y _`anio`_.

```r
#Agregando una nueva columna con el numero de mes
data$mes <- as.numeric(month(data$date))
#Agregando una nueva columna con el numero del año
data$anio <- as.numeric(year(data$date))
```

Por ultimos, se uso un _"%>%"_ para poder obbtener el promedio por mes. Esto se observa en lasiguiente linea de codigo:

```r
#Procedimiento elaborado para agrupar por (anio y mes) y agregarle la media
#Se uso "%>%" para realizar esta operacion
df <- data %>% 
  group_by(anio,mes) %>%
  summarize(promedio_goles=mean(sumagoles))
```
Por ultimo se visualizaron los resultados:

|FIELD1|anio      |mes     |promedio_goles|
|------|----------|--------|--------------|
|      |<dbl>     |<dbl>   |<dbl>         |
|1     |2010      |8       |2.2           |
|2     |2010      |9       |2.42          |
|3     |2010      |10      |3.03          |
|4     |2010      |11      |2.90          |
|5     |2010      |12      |2.73          |
|6     |2011      |1       |3             |

### - _Punto 3_

Posteriormente se reordenaron los datos para generar la serie de tiempo.
<br/>
Se ordeno los datos con la siguiente linea de codigo:

```r
#Oredenando de los campos anio y mes
df1 <- df[order(df$anio,df$mes),]
```
 
 Finalmente se genero la serie de tiempo con:
 ```r
#Generando serie de tiempo
goles.ts <- ts(df1[,3],start = c(2010,8), frequency = 12,end = c(2019,12))
```
### - _Punto 4_

Por ultimo, se genero la grafica de la serie de tiempo con la siguiente linea de codigo:
 ```r
#Graficando la serie de tiempo 
plot(goles.ts, xlab = "", ylab = "")
title(main = "Serie de Goles",
      ylab = "Resultados de partidos en goles",
      xlab = "Mes")
```

La grafica es la siguiente:

































## Postwork. Alojar el fichero a un local host de MongoDB 

### OBJETIVO

- Realizar el alojamiento del fichero de un fichero `.csv` a una base de datos (BDD), en un local host de Mongodb a traves de `R`

#### REQUISITOS

- Mongodb Compass
- librerías `mongolite`
- Nociones básicas de manejo de BDD

#### DESARROLLO


Utilizando el manejador de BDD _Mongodb Compass_ (previamente instalado), deberás de realizar las siguientes acciones: 

- Alojar el fichero  `data.csv` en una base de datos llamada `match_games`, nombrando al `collection` como `match`

- Una vez hecho esto, realizar un `count` para conocer el número de registros que se tiene en la base

- Realiza una consulta utilizando la sintaxis de **Mongodb**, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

- Por último, no olvides cerrar la conexión con la BDD
 
