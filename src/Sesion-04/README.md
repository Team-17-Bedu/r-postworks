

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
