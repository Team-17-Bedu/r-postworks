

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 4</strong></h4>
  <p align="center">
     Algunas distribuciones, teorema central del límite y contraste de hipótesis
    <br />
    <a href="Postwork-04.R"><strong>Explora el código »</strong></a>
    <br/>
    <br/>
  </p>
  
</p>

## Objetivos
* Investigar la dependencia o independecia de las variables aleatorias X y Y, el número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante.
## Requisitos
- RStudio | PyCharm
- R

## Descripción
Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap, revisa bibliografía en internet para que tengas nociones de este desarrollo.

1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).
## Solución
### - _Punto 1_
Primero se lee el dataset
```r
# Lectura del dataset
datos <- read.csv("dataurl1920.csv")
```

Posteriormente se convierte el dipo de dato de las columnas _FTAG_ y _FTHG_ de `int` a `factor`
```r
# Conversion de las columnas FTHG y FTAG (int a factor)
datos <- mutate(datos, across(FTHG:FTAG, factor))
```
Se obtiene la probabilidad conjunta
```r
# Obtener la probabilidad conjunta
goles <- prop.table(table(local = datos$FTHG, visitante = datos$FTAG))
```
Por ultimo se obtiene la tabla de cocientes
```r
# Se obtiene la tabla de cocientes
conjunto <- goles / outer(rowSums(goles), colSums(goles))
```

Esto da como resultado la siguiente tabla

|local|0  |1        |2        |3        |4        |5        |
|-----|---|---------|---------|---------|---------|---------|
|     0  |1.0477941|0.9023066|0.7996633|1.9191919|0.9595960|4.3181818|
|     1  |0.9102050|1.0526911|1.1372989|0.7996633|0.9595960|0.0000000|
|     2  |1.1007130|1.0025629|0.9477491|0.6397306|0.8529742|0.0000000|
|     3  |1.0294118|1.0447761|0.8641975|1.1111111|1.1111111|0.0000000|
|     4  |0.7983193|1.0127932|1.3403880|0.0000000|3.0158730|0.0000000|
|     5  |0.6985294|1.0634328|1.7592593|0.0000000|0.0000000|0.0000000|
|     6  |2.7941176|0.0000000|0.0000000|0.0000000|0.0000000|0.0000000|


### - _Punto 2_
Primero se define la funcion `bootstrap` para poder ejecutar el procedimiento homonimo
```r
bootstrap <- function(){
  # Generacion de una muestra "replica" del mismo tamaño que la
  # original
  sdatos <- sample_frac(datos, size = 1, replace = T)
  goles <- prop.table(table(local = sdatos$FTHG,
                            visitante = sdatos$FTAG))
  conjunto <- goles / outer(rowSums(goles), colSums(goles))
  return(conjunto)
}
```
Se define una semilla para poder reproducir los resultados obtenidos
```r
set.seed(1999)
```
Se obtiene una replica de la muestra origina
```r 
boot <- replicate(1000, bootstrap(), simplify = F)
```
Por ultimo se genera una grafica que representara la correlacion donde x_testada = 1 o en su representación grafica, la linea roja, que puede indicar dependencia
```r
# Combinación de filas y columnas
crossing(
  row = seq_len(nrow(goles)),
  col = seq_len(ncol(goles))
) %>%
  # Seleccion de celdas en todas las muestras
  mutate(
    indices = map2(row, col, function(x, y)
      sapply(boot, function(m) m[x, y]))
  ) %>%
  # Conversion de las filas y columnas en factores
  mutate(
    row = factor(str_glue("Local: {row-1}")),
    col = factor(str_glue("Visitante: {col-1}"))
  ) %>%
  # Desanida la columna de indices
  unnest(indices) %>%
  # Supresion de valores NaN
  filter(!is.nan(indices)) %>%
  # Supresion de las combinaciones con un solo valor distinto
  group_by(row, col) %>%
  filter(n_distinct(indices) > 1) %>%
  ungroup() %>%
  # Generacion del grafico
  ggplot(aes(indices)) +
    # Generacion de un grid graficando por combinacion de fila
    # y columna, donde no se excluiran frames vacios
    facet_wrap(~ row + col, scales = "free", ncol = ncol(goles), drop = F) +
    geom_histogram(bins = 12) +
    geom_vline(xintercept = 1, color = "red") +
    labs(
      title = "Probabilidades Conjuntas sobre el Producto de Probabilidades Marginales",
      x = NULL, y = NULL
    ) +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.grid = element_blank()
    )
```

Lo anterior dio como resultado la siguiente gráfica

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-04-plot.png" alt="dataset">
  </a>
</p>
