# Postwork Sesi�n 7
# 
# Utilizando el manejador de BDD Mongodb Compass (previamente instalado), 
# deber�s de realizar las siguientes acciones: 
library(mongolite) 
# - Alojar el fichero  `data.csv` en una base de datos llamada `match_games`,
# nombrando al `collection` como `match`
match <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-07/Postwork/data.csv", row.names = 1)
# - Una vez hecho esto, realizar un `count` para conocer el n�mero de 
# registros que se tiene en la base
# 
# - Realiza una consulta utilizando la sintaxis de **Mongodb**, en la base 
# de datos para conocer el n�mero de goles que meti� el Real Madrid el 09 
# de diciembre de 2017 y contra que equipo jug�, �perdi� � fue goleada?
#   
# - Por �ltimo, no olvides cerrar la conexi�n con la BDD
#
mdb_match <- mongo(collection = "match", db = "match_games")

mdb_match$insert(match)

mdb_match$count()

mdb_match$find('
{
  "Date": "2017-12-09", 
  "$or": [
    {"HomeTeam": "Real Madrid"}, 
    {"AwayTeam": "Real Madrid"}
  ]
}
')

mdb_match$disconnect(T)