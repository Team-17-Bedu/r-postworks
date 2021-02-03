# Titulo : Postworks seccion 7
# Objetivo : - Realizar el alojamiento del fichero de un fichero .csv
#              a una base de datos (BDD), en una local host de
#              Mongodb a traves de R
# Creado por: Alejandro Viveros Sanchez

#
# 1. Alojar el fichero data.csv en una base de datos llamada
#    match_games, nombrando al collection como match
#

#Instalando librerias
install.packages("mongolite")

#Uso de libreria
library("mongolite")

#Conectando con Mongolite
con <- mongo("match", url = "mongodb+srv://Alejandro:Alfabeta1@cluster0.kwzlt.mongodb.net/match_games?retryWrites=true&w=majority")

#
# 2. Una vez hecho esto, realizar un count para conocer el numero 
#    que se tiene en la base
#

#Realizando la cuenta
print("Resultado de la cuenta de documentos en R:")
con$count()

#
# 3. Realiza una consulta utilizando la sintaxis de Mongodb,
#    en la base de datos para conocer el numero de goles que
#    metio el Real Madrid el 20 de diciembre de 2015 y contra
#    que equipo jugo �perdio o fue goleada?
#
#Consulta del real madrid
consulta <- con$find(
  query = '{"Date":"2017-12-03"}'
)

#Impriendo consulta
print(consulta)
#Consulta 2, con datos anexados de internet

consulta <- con$find(
  query = '{"Date":"20/12/2015","HomeTeam":"Real Madrid"}'
)
#Impriendo consulta
print(consulta)

#
# 4. Por ultimo, no olvides cerrar la conexion con la BDD
#

#Quitando la conexion
rm(con)