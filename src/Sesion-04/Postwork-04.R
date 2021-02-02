# Titulo    : Postwork Sesion 4
# Objetivo  : - Investigar la dependencia o independecia de
#               las variables aleatorias X y Y, el número de
#               goles anotados por el equipo de casa y el número
#               de goles anotados por el equipo visitante.
# Creado por: Ivan Montiel Cardona

library(dplyr)
library(tidyr)
library(stringr)
library(purrr)
library(ggplot2)

# Asignacion dinamica del directorio de trabajo
dir <- paste0(getwd(), "/src/Sesion-03/datasets")
setwd(dir)

# 1. Habiendo estimado las probabilidades conjuntas de que el
# equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo
# visitante anote Y=y goles (y=0,1,... ,6), en un partido.
# Obtén una tabla de cocientes al dividir estas probabilidades
# conjuntas por el producto de las probabilidades marginales
# correspondientes.

# Lectura del dataset
datos <- read.csv("dataurl1920.csv")

# Conversion de las columnas FTHG y FTAG (int a factor)
datos <- mutate(datos, across(FTHG:FTAG, factor))

# Obtener la probabilidad conjunta
goles <- prop.table(table(local = datos$FTHG, visitante = datos$FTAG))

# Se obtiene la tabla de cocientes
# Solución al punto 1
conjunto <- goles / outer(rowSums(goles), colSums(goles))

# 2. Mediante un procedimiento de bootstrap, obtén más cocientes
# similares a los obtenidos en la tabla del punto anterior. Esto
# para tener una idea de las distribuciones de la cual vienen los
# cocientes en la tabla anterior. Menciona en cuáles casos le
# parece razonable suponer que los cocientes de la tabla en el
# punto 1, son iguales a 1 (en tal caso tendríamos independencia
# de las variables aleatorias X y Y).

# Definición de la funcion bootstrap para ejecutar
# el procedimiento bootstrap
bootstrap <- function(){
  # Generacion de una muestra "replica" del mismo tamaño que la
  # original
  sdatos <- sample_frac(datos, size = 1, replace = T)
  goles <- prop.table(table(local = sdatos$FTHG,
                            visitante = sdatos$FTAG))
  conjunto <- goles / outer(rowSums(goles), colSums(goles))
  return(conjunto)
}

# Definicion de la semilla para que el procedimiento
# sea reproducible
set.seed(1999)

# Obtencion de la replica de la muestra original
boot <- replicate(1000, bootstrap(), simplify = F)

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