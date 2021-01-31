# Titulo    : Postwork Sesion 3
# Objetivo  : - Realizar descarga de archivos desde internet
#             - Generar nuevos data frames
#             - Visualizar probabilidades estimadas con la ayuda de gráficas
# Creado por: Ivan Montiel Cardona

library(dplyr)
library(tidyr)

# Asignacion dinamica del directorio de trabajo
dir <- paste0(getwd(), "/src/Sesion-03/datasets")
setwd(dir)

# 1. Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas
# de frecuencias relativas para estimar las siguientes probabilidades:
#  - La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
#  - La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
#  - La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que
#    juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

# Lectura del dataset
data <- read.csv("dataframe-postwork-02.csv")

# Obtencion de longitud total de datos
total_datos <- nrow(data)

# Obtencion de tabla de frecuencia para equipos locales
df_locales <- as.data.frame(table(data$FTHG))
colnames(df_locales) <- c("goles", "frecuencia")

# Calculo de probabilidad marginal de los equipos locales y adicion al dataframe
df_locales <- cbind(df_locales,
                    probabilidad_marginal = (df_locales$frecuencia / total_datos))

# Creacion de subconjunto para x goles (x=0,1,2,)
# Solucion a la primera seccion del punto 1
df_locales_x <- df_locales[1:3, ]

# Obtencion de tabla de frecuencia para equipos visitantes
df_visitantes <- as.data.frame(table(data$FTAG))
colnames(df_visitantes) <- c("goles", "frecuencia")

# Calculo de probabilidad marginal de los equipos visitantes y adicion al dataframe
df_visitantes <- cbind(df_visitantes,
                       probabilidad_marginal= (df_visitantes$frecuencia / total_datos))

# Creacion de subconjunto para y goles (y=0,1,2,)
# Solucion a la segunda seccion del punto 1
df_visitantes_y <- df_visitantes[1:3, ]

# Union de columnas FTHG y FTAG
#data_conjunto <- data[data$FTHG <= 3 & data$FTAG <= 3, ]
data_conjunto <- unite_(data, "resultado", c("FTHG", "FTAG"), sep = " ",remove = FALSE)

# Obtencion de tabla de frecuencias conjuntas
df_conjunto <- as.data.frame(table(data_conjunto$FTHG, data_conjunto$FTAG))
colnames(df_conjunto) <- c("local", "visitante", "frecuencia")

# Calculo de probabilidad conjunta de los equipos y adicion al dataframe
# Solucion a la tercera seccion del punto 1
df_conjunto <- cbind(df_conjunto,
                     probabilidad = (df_conjunto$frecuencia / total_datos))

# 2. Realiza lo siguiente:
#   - Un gráfico de barras para las probabilidades marginales estimadas del número
#     de goles que anota el equipo de casa
#   - Un gráfico de barras para las probabilidades marginales estimadas del número
#     de goles que anota el equipo visitante.
#   - Un HeatMap para las probabilidades conjuntas estimadas de los números de goles
#     que anotan el equipo de casa y el equipo visitante en un partido.

# Solucion a la primera seccion del punto 2
barplot(height = df_locales$probabilidad_marginal,
        names = df_locales$goles,
        main = "Probabilidad marginal para equipos locales",
        xlab = "Goles",
        ylab = "Probabilidad",
        col = "#69b3a2")

# Solucion a la segunda seccion del punto 2
barplot(height = df_visitantes$probabilidad_marginal,
        names = df_visitantes$goles,
        main = "Probabilidad marginal para equipos visitantes",
        xlab = "Goles",
        ylab = "Probabilidad",
        col = "#69b3a2")

# Importacion de biblioteca ggplot2
library(ggplot2)

# Comversion de datos de string a int
df_conjunto$local <- strtoi(df_conjunto$local)
df_conjunto$visitante <- strtoi(df_conjunto$visitante)

# Generacion de HeatMap
# Solucion a la tercera seccion del punto 2
ggplot(df_conjunto, aes(local,
                        visitante,
                        fill= probabilidad)) +
  geom_tile() +
  labs(x = "Equipo Local",
       y = "Equipo Visitante",
       fill = "Probabilidad",
       title = "HeatMap de probabilidades conjuntas")
