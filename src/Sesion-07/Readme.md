

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center"><strong>Postworks - R</strong></h3>
  <h4 align="center"><strong>Postwork 7</strong></h4>
  <p align="center">
     RStudio Cloud - Github, conexiones con BDs y lectura de datos externos
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

3. Realiza una consulta utilizando la sintaxis de **Mongodb**, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

4. Por último, no olvides cerrar la conexión con la BDD.

## Solución 

Primero se descargaron las bibliotecas necesarias para la realización del programa. La biblioteca correspondiente es _`mongolite`_. La procedemos a instalar con la siguiente linea de codigo:

```r
#Instalando librerias
install.packages("mongolite")
```
<br/>

Posteriormente se hicieron uso de la _libreria_  correspondiente con:

```r
#Uso de libreria
library("mongolite")
```

### - _Punto 1_

Primeramente, se creo una base de datos llamada _match_games_ en **Mongo Compass**. 
<br/>Ya creada la base de datos, se crea una colección llamada _match_, para posteriormente exportar el docuemento _data.csv_. Esto se puede apreciar en la siguiente imagen:

<p align="center">
  <a href="https://github.com/Team-17-Bedu/r-postworks">
    <img src="https://github.com/Team-17-Bedu/r-postworks/blob/main/img/Sesion-06-img.jpeg" alt="Imagen Sesion 7">
  </a>
</p>

Como se observa en la imagen se logro crear colección correctamente.

### - _Punto 2_

Ahora toca realizar las consultas correspondientes atraves de _R Studio_. Para ello, se instalo la biblioteca _`mongolite`_. En la siguiente linea de codigo se instalo tal dependencia:

```r
#Instalando librerias
install.packages("mongolite")
```
Y para hacer uso de tal _biblioteca_ se uso:

```r
#Uso de libreria
library("mongolite")
```
Ahora se conecto a la _base de datos_ y la _colección_ con la siguiente linea de codigo:

```r
#Conectando con Mongolite
con <- mongo("match", url = "mongodb+srv://Alejandro:<Password>@cluster0.kwzlt.mongodb.net/match_games?retryWrites=true&w=majority")
```
Explicando el codigo anterior. El primer argumento es la _colección_, mientras que el segundo parametro es el _Conection String_.
<br/>

Finalmente se realizo un _count_ a la _colección_.

```console
[1] "Resultado de la cuenta de documentos en R:"
> con$count()
[1] 1140
```
### - _Punto 3_

Se realizo una consulta mas detallada en `R`. La cual era, conocer el numero de goles que metio el Real Madrid el 20 de Diciembre de 2015 y que contra que equipo jugo. Para tal consulta se escribo la siguiente linea de codigo:

```r
#Consulta del real madrid
consulta <- con$find(
  query = '{"Date":"2017-12-03","HomeTeam":"Real Madrid"}'
)
```

Los resultados obtenidos son:

```console
> print(consulta)
data frame with 0 columns and 0 rows
```
El resultado se pudo deber a que el archivo _data.csv_. No cuenta con registros menores al año 2017.

### - _Punto 4_

Por ultimo se cerro la conexión con la siguiente linea de codigo:

```r
#Cerrando la conexion
rm(con)
```