<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 6</strong></h4>
  <p align="center">
     Series de tiempo
    <br />
    <a href="https://github.com/begeistert/microcontrollers-ccs-c-compiler"><strong>Explora el código »</strong></a>
    <br/>
    <br/>
  </p>
  
</p>

## Objetivos
- Aprender a crear una serie de tiempo en `R`

## Requisitos
- R Studio | PyCharm
- R

## Descripción 
Haciendo uso de los conocimiento adquiridos durante la sesión se graficará un seria de tiempo del documento _.csv_

Importar el conjunto de datos match.data.csv a `R` y realiza lo siguiente:

1. Se le agregara una nueva columna llamada `sumagoles` que contenga la suma de goles por partido.

2. Se obtendra el promedio por mes de la suma de goles. 

3. Se creará la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.

4. Se graficará la serie de tiempo. Además, se agregará las etiquetas describiendo la grafica.

## Solución 

Primero, se descargaron las bibliotecas necesarias para la realización del programa. Las cuales son: _`dplyr`_ y _`lubridate`_.

```r
#Instalacion del paquete "dplyr" para la manipulacion de dataframes.
install.packages("dplyr")
#Instalacion del paquete "lubridate" para la manipulacion de dataframes.
install.packages("lubridate")
```
<br/>

Posteriormente se hicieron uso de las _bibliotecas_  correspondientes:

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

Posteriormente, se ejecuto la siguiente linea de codigo:
```r
#Revisando contenido del DataFrame
head(data)
```

<br/>
Con el fin de observar el dataframe ya cargado. Se genero la siguiente tabla:

|index |date      |home.team|home.score|away.team|away.score|
|------|----------|---------|----------|---------|----------|
|1     |2010-08-28|Hercules |0         |Ath Bilbao  |1      |     
|2     |2010-08-28|Levante  |1         |Sevilla  |4         |      
|3     |2010-08-28|Malaga   |1         |Valencia |3         |      
|4     |2010-08-29|Espanol  |3         |Getafe   |1         |      
|5     |2010-08-29|La Coruna|0         |Zaragoza  |0        |      
|6     |2010-08-29|Mallorca |0         |Real Madrid|0       |  
```r
#El resultado sera la suma de goles del equipo visitante más los del equipo local
data$sumagoles <- data$home.score + data$away.score
```

### - _Punto 2_

Para obtener el objetivo del punto dos, se agrego dos campos nuevos: _`mes`_ y _`anio`_.

```r
#Agregando una nueva columna con el numero de mes
data$mes <- as.numeric(month(data$date))
#Agregando una nueva columna con el numero del año
data$anio <- as.numeric(year(data$date))
```

Por ultimos, se uso un _"%>%"_ para poder obtener el promedio por mes. Esto se observa en la siguiente linea de codigo:

```r
#Procedimiento elaborado para agrupar por (anio y mes) y agregarle la media
#Se uso "%>%" para realizar esta operacion
df <- data %>% 
  group_by(anio,mes) %>%
  summarize(promedio_goles=mean(sumagoles))
```
Por ultimo se visualizaron los resultados:

|index|anio      |mes     |promedio_goles|
|------|----------|--------|--------------|
|      |<dbl>     |<dbl>   |<dbl>         |
|1     |2010      |8       |2.2           |
|2     |2010      |9       |2.42          |
|3     |2010      |10      |3.03          |
|4     |2010      |11      |2.90          |
|5     |2010      |12      |2.73          |
|6     |2011      |1       |3             |

<br/>

### - _Punto 3_

Posteriormente, se reordenaron los datos para generar la serie de tiempo.
<br/>
Se ordeno los datos con la siguiente linea de codigo:

```r
#Ordenando de los campos anio y mes
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

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-07-img.jpeg" alt="Imagen Sesion 6">
  </a>
</p>

###### [Equipo 17](https://github.com/Team-17-Bedu)
