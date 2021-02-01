

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 1</strong></h4>
  <p align="center">
    Introducción a R y Software
    <br />
    <a href="https://github.com/begeistert/microcontrollers-ccs-c-compiler"><strong>Explora el código »</strong></a>
    <br/>
    <br/>
  </p>
  
</p>

## Objetivos
El Postwork tiene como objetivo que practiques los comandos básicos aprendidos durante la sesión, de tal modo que sirvan para reafirmar el conocimiento.

## Requisitos
- Concluir los retos
- Haber estudiado los ejemplos durante la sesión

## Descripción
El siguiente postwork, te servirá para ir desarrollando habilidades como si se tratara de un proyecto que evidencie el progreso del aprendizaje durante el módulo, sesión a sesión se irá desarrollando. A continuación aparecen una serie de objetivos que deberás cumplir, es un ejemplo real de aplicación y tiene que ver con datos referentes a equipos de la liga española de fútbol (recuerda que los datos provienen siempre de diversas naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos y generar análisis interesantes que se pueden aplicar a otras áreas. Siendo así damos paso a las instrucciones:

1. Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

2. Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

3. Consulta cómo funciona la función table en R al ejecutar en la consola ?table

Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:


- La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...).
- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...).
- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...).

## Solución
Primero se descargaron las bibliotecas necesarias para la realización del programa. La biblioteca correspondiente es _`dplyr`_, _`tidyr`_, _`janitor`_. La procedemos a instalar con la siguiente linea de codigo:

```r
#Instalando librerias
install.packages("dplyr")
install.packages("tidyr")
install.packages("janitor")
```
Segundo se fija la ruta de trabajo 

```r
dir <- paste0(getwd(), "/src/Sesion-01/datasets")
setwd(dir)
```

Guardamos el enlace en una variable 
```r
Futbol <-"https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
```

Descargamos el dataset 
```r
download.file(url = Futbol, destfile = "SP1.csv", mode = "wb")
```

Leemos el dataset 
```r
data <- read.csv("SP1.csv")
```

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura.jpeg" alt="dataset">
  </a>
</p>

Hacer tabla de frecuencia de los locales 
```r
TF_locales<-datagoles%>%group_by(FTHG)%>%summarise(frequency=n())
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura-2.jpeg" alt="Tabla Frecuencia de locales">
  </a>
</p>

Hacer tabla de frecuencia de los visitantes 
```r
TF_visitantes<-datagoles%>%group_by(FTAG)%>%summarise(frequency=n())
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura-3.jpeg" alt="Tabla Frecuencia de locales">
  </a>
</p>

Calcular probabiliad marginal de los locales 
```r
probabilidad_marginal_local<-TF_locales$frequency /total_datos
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura-3.jpeg" alt="Tabla de probabilidades marginales">
  </a>
</p>

Calcular probabilidad marginal de los visitantes 
```r
probabilidad_marginal_visitantes<-TF_visitantes$frequency/total_datos
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura-3.jpeg" alt="Tabla Frecuencia de locales">
  </a>
</p>

Visualizar tabla con la frecuencia y su probabilidad de los locales 
```r
TablaLocales<-data.frame(TF_locales,probabilidad_marginal_local)
TablaLocales$NGoles=TablaLocales$FTHG
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura-4.jpeg" alt="Tabla Frecuencia de locales">
  </a>
</p>
Visualizar tabla con la frecuencia y su probabilidad de los visitantes 

```r
TablaVisitantes<-data.frame(TF_visitantes,probabilidad_marginal_visitantes)
TablaVisitantes$NGoles=TablaVisitantes$FTAG
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura-5.jpeg" alt="Tabla Frecuencia de visitantes">
  </a>
</p>

Creacion de tabla de frecuencia de los marcadores 
```r
tabla_conjunta <- unite(datagoles,Goles,c(1:2),  sep = " ", remove = TRUE)
tablaConjunta_frecuencia <-tabla_conjunta %>%group_by(Goles) %>% summarise(frequency = n())
```
Realiazr la probabilidad conjunta 
```r
tablacojunta_probabilidad <- tablaConjunta_frecuencia$frequency / total_datos
```
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-01-captura-6.jpeg" alt="Tabla Final">
  </a>
</p>
