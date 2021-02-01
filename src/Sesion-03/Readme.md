<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 3</strong></h4>
  <p align="center">
     Análisis Exploratorio de Datos (AED o EDA)
    <br />
    <a href="https://github.com/begeistert/microcontrollers-ccs-c-compiler"><strong>Explora el código »</strong></a>
    <br/>
    <br/>
  </p
</p>

## Objetivos
- Realizar descarga de archivos desde internet
- Generar nuevos data frames
- Visualizar probabilidades estimadas con la ayuda de gráficas

## Requisitos
- R Studio | PyCharm
- R

## Descripción 
Haciendo uso de los conocimiento adquiridos durante la sesión se graficarán las probabilidades marginales y conjuntas para el número de goles que anotan en un partido el equipo _de casa_ o el equipo _visitante_

1. Con el último dataset obtenido en el postwork de la `sesión 2`, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades
	* La probabilidad (`marginal`) de que el equipo que juega en casa anote x goles (x=0,1,2,)
	* La probabilidad (`marginal`) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
	* La probabilidad (`conjunta`) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
2. Realice lo siguiente
	* Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
	* Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
	* Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.

## Solución 

Importación de bibliotecas `dplyr` y `tidyr`

```r
library(dplyr)
library(tidyr)
library(ggplot2)
```

Lectura del dataset
```r
data <- read.csv("dataurl1920.csv")
```

Se obtiene la longitud del data frame y se almacena en la variable `total_datos`

```r
# Obtencion de longitud total de datos
total_datos <- nrow(data)
```

### - _Punto 1_
Se obtiene la probabilidad (`marginal`) de que el equipo que juega en casa anote x goles (x=0,1,2,)
```r
# Obtencion de tabla de frecuencia para equipos locales
df_locales <- as.data.frame(table(data$FTHG))
colnames(df_locales) <- c("goles", "frecuencia")

# Calculo de probabilidad marginal de los equipos locales y adicion al dataframe
df_locales <- cbind(df_locales,
                    probabilidad_marginal = (df_locales$frecuencia / total_datos))
```
Una vez ejecutado el código anterior se obtiene como resultado la siguiente tabla

|index|goles|frecuencia|probabilidad_marginal|
|-----|-----|----------|---------------------|
|1    |0    |88        |0.231578947          |
|2    |1    |132       |0.347368421          |
|3    |2    |99        |0.260526316          |
|4    |3    |38        |0.100000000          |
|5    |4    |14        |0.036842105          |
|6    |5    |8         |0.021052632          |
|7    |6    |1         |0.002631579          |

Posteriormente se obtendrá la probabilidad (`marginal`) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

```r
# Obtencion de tabla de frecuencia para equipos visitantes
df_visitantes <- as.data.frame(table(data$FTAG))
colnames(df_visitantes) <- c("goles", "frecuencia")

# Calculo de probabilidad marginal de los equipos visitantes y adicion al dataframe
df_visitantes <- cbind(df_visitantes,
                       probabilidad_maginal= (df_visitantes$frecuencia / total_datos))
```

Una vez ejecutado el código anterior se obtiene como resultado la siguiente tabla

|index|goles|frecuencia|probabilidad_marginal|
|-----|-----|----------|---------------------|
|1    |0    |136       |0.357894737          |
|2    |1    |134       |0.352631579          |
|3    |2    |81        |0.213157895          |
|4    |3    |18        |0.047368421          |
|5    |4    |9         |0.023684211          |
|6    |5    |2         |0.005263158          |

Por ultimo se obtendrá la probabilidad (`conjunta`) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

```r
# Obtencion de tabla de frecuencias conjuntas
df_conjunto <- as.data.frame(table(data$FTHG, data_conjunto$FTAG))
colnames(df_conjunto) <- c("local", "visitante", "frecuencia")

# Calculo de probabilidad conjunta de los equipos y adicion al dataframe
# Solucion a la tercera seccion del punto 1
df_conjunto <- cbind(df_conjunto,
                     probabilidad = (df_conjunto$frecuencia / total_datos))

```

Una vez ejecutado el código anterior se obtiene como resultado la siguiente tabla
<details><summary>Resultado (Tabla)</summary>
<p>
	
|index|local|visitante|frecuencia|probabilidad|
|-----|-----|---------|----------|------------|
|1    |0    |0        |33        |0.086842105 |
|2    |1    |0        |43        |0.113157895 |
|3    |2    |0        |39        |0.102631579 |
|4    |3    |0        |14        |0.036842105 |
|5    |4    |0        |4         |0.010526316 |
|6    |5    |0        |2         |0.005263158 |
|7    |6    |0        |1         |0.002631579 |
|8    |0    |1        |28        |0.073684211 |
|9    |1    |1        |49        |0.128947368 |
|10   |2    |1        |35        |0.092105263 |
|11   |3    |1        |14        |0.036842105 |
|12   |4    |1        |5         |0.013157895 |
|13   |5    |1        |3         |0.007894737 |
|14   |6    |1        |0         |0.000000000 |
|15   |0    |2        |15        |0.039473684 |
|16   |1    |2        |32        |0.084210526 |
|17   |2    |2        |20        |0.052631579 |
|18   |3    |2        |7         |0.018421053 |
|19   |4    |2        |4         |0.010526316 |
|20   |5    |2        |3         |0.007894737 |
|21   |6    |2        |0         |0.000000000 |
|22   |0    |3        |8         |0.021052632 |
|23   |1    |3        |5         |0.013157895 |
|24   |2    |3        |3         |0.007894737 |
|25   |3    |3        |2         |0.005263158 |
|26   |4    |3        |0         |0.000000000 |
|27   |5    |3        |0         |0.000000000 |
|28   |6    |3        |0         |0.000000000 |
|29   |0    |4        |2         |0.005263158 |
|30   |1    |4        |3         |0.007894737 |
|31   |2    |4        |2         |0.005263158 |
|32   |3    |4        |1         |0.002631579 |
|33   |4    |4        |1         |0.002631579 |
|34   |5    |4        |0         |0.000000000 |
|35   |6    |4        |0         |0.000000000 |
|36   |0    |5        |2         |0.005263158 |
|37   |1    |5        |0         |0.000000000 |
|38   |2    |5        |0         |0.000000000 |
|39   |3    |5        |0         |0.000000000 |
|40   |4    |5        |0         |0.000000000 |
|41   |5    |5        |0         |0.000000000 |
|42   |6    |5        |0         |0.000000000 |


</p>
</details>
<br/>

### - _Punto 2_

Se generá un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa

```r
barplot(height = df_locales$probabilidad_marginal,
        names = df_locales$goles,
        main = "Probabilidad marginal para equipos locales",
        xlab = "Goles",
        ylab = "Probabilidad",
        col = "#69b3a2")
```

Despues de lo anterior se obtiene la siguiente gráfica de barras

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-03-plt-1.png" alt="Plot 1">
  </a>
</p>

Posteriormente se generá otro gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante

```r
barplot(height = df_visitantes$probabilidad_marginal,
        names = df_visitantes$goles,
        main = "Probabilidad marginal para equipos visitantes",
        xlab = "Goles",
        ylab = "Probabilidad",
        col = "#69b3a2")
```

Despues de lo anterior se obtiene la siguiente gráfica de barras

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-03-plt-2.png" alt="Plot 2">
  </a>
</p>

Por último se generará un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.

Debido a que los datos presentes en las columnas `FTHG` y `FTAG` son de tipo `string` se realizo una conversión de los datos a `int`

```r
df_conjunto$local <- strtoi(df_conjunto$local)
df_conjunto$visitante <- strtoi(df_conjunto$visitante)
```

Generación del HeatMap

```r
ggplot(df_conjunto, aes(local,
                        visitante,
                        fill= probabilidad)) +
  geom_tile() +
  labs(x = "Equipo Local",
       y = "Equipo Visitante",
       fill = "Probabilidad",
       title = "HeatMap de probabilidades conjuntas")
```

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-03-plt-3.png" alt="Plot 3">
  </a>
</p>


###### [Equipo 17](https://github.com/Team-17-Bedu)