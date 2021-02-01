# Titulo    : Postwork Sesion 4
# Objetivo  : - Investigar la dependencia o independecia de
#               las variables aleatorias X y Y, el número de
#               goles anotados por el equipo de casa y el número
#               de goles anotados por el equipo visitante.
# Creado por: Ivan Montiel Cardona

# Postwork Sesión 4
# -------------------------------------------------------------------------
#
# Ahora investigarás la dependencia o independencia del número de goles
# anotados por el equipo de casa y el número de goles anotados por el equipo
# visitante mediante un procedimiento denominado bootstrap, revisa
# bibliografía en internet para que tengas nociones de este desarrollo.
#
# 1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa
# anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles
# (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir
# estas probabilidades conjuntas por el producto de las probabilidades
# marginales correspondientes.
#
# 2. Mediante un procedimiento de bootstrap, obtén más cocientes similares a
# los obtenidos en la tabla del punto anterior. Esto para tener una idea de
# las distribuciones de la cual vienen los cocientes en la tabla anterior.
# Menciona en cuáles casos le parece razonable suponer que los cocientes de
# la tabla en el punto 1, son iguales a 1
# (en tal caso tendríamos independencia de las variables aleatorias X y Y).
#
# Asignacion dinamica del directorio de trabajo
dir <- paste0(getwd(), "/src/Sesion-03/datasets")
setwd(dir)

datos <- read.csv("dataurl1920.csv")

datos <- mutate(datos, across(FTHG:FTAG, factor))

goles <- prop.table(table(Home = data$FTHG, Away = data$FTAG))

quots <- goles / outer(rowSums(goles), colSums(goles))

bootstrap_goals <- function(){
  sdata <- sample_frac(data, size = 1, replace = T) # Muestra del mismo tamaño que la base original con remplazo
  goals <- prop.table(table(Home = sdata$FTHG, Away = sdata$FTAG))
  quots <- goals / outer(rowSums(goals), colSums(goals))
  return(quots)
}

set.seed(234)

# Bootstrap
bs <- replicate(1000, bootstrap_goals(), simplify = F)

# Combinación de columnas y filas
crossing(
  row = seq_len(nrow(goals)),
  col = seq_len(ncol(goals))
) %>%
  # Recolección de celdas en todas las muestras
  mutate(
    indices = map2(row, col, function(x, y) sapply(bs, function(m) m[x, y]))
  ) %>%
  # Se transforman en factor las columnas row y col
  mutate(
    row = factor(str_glue("Casa: {row-1}")),
    col = factor(str_glue("Visitante: {col-1}"))
  ) %>%
  # Se desprenden los indices
  unnest(indices) %>%
  # Se eliminan aquellos valores NaN (No son números)
  filter(!is.nan(indices)) %>%
  # Se eliminan aquellas combinaciones donde solo hay un valor distinto
  group_by(row, col) %>%
  filter(n_distinct(indices) > 1) %>%
  ungroup() %>%
  # Gráfico
  ggplot(aes(indices)) +
    # Paneles por combinación de fila y columna
    # Número de columnas igual a la establecida en tablas anteriores
    # No se eliminan paneles vacíos
    facet_wrap(~ row + col, scales = "free", ncol = ncol(goals), drop = F) +
    geom_histogram(bins = 12) +
    geom_vline(xintercept = 1, color = "red") +
    labs(
      title = "Bootstrap: Probabilidades Conjuntas entre Producto de Probabilidades Marginales",
      subtitle = expression(bar(x)==1 ~ "(rojo) puede indicar independencia"),
      caption = "Paneles vacíos indican menos de un valor distinto",
      x = NULL, y = NULL
    ) +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.grid = element_blank()
    ) +
    ggsave("img/pws04.png", width = 8.4, height = 12)