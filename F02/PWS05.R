#Postwork sesion 5 
library(tidyverse)
library(fbRanks)
# A partir del conjunto de datos de soccer de la liga espa�ola de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame 
# SmallData, que contenga las columnas date, home.team, home.score, away.team y away.score; esto lo puede hacer con ayuda de la funci�n select del paquete dplyr. 
# Luego establece un directorio de trabajo y con ayuda de la funci�n write.csv guarda el data frame como 
# un archivo csv con nombre soccer.csv. Puedes colocar como argumento row.names = FALSE en write.csv.
url <- c("https://www.football-data.co.uk/mmz4281/1920/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1718/SP1.csv")

data <- map(url,read_csv)
SmallData <- data %>% 
  map(function(data) data %>% select(Date, HomeTeam, AwayTeam, FTHG, FTAG)) %>% 
  reduce(rbind) %>% 
  rename(date = Date, home.team = HomeTeam,home.score = FTHG,away.team = AwayTeam,away.score = FTAG) %>% 
  

setwd("C:/Users/Aleja/Desktop")
write.csv(SmallData, "soccer.csv",row.names = F)
# Con la funci�n create.fbRanks.dataframes del paquete fbRanks importe el archivo soccer.csv a R y al 
# mismo tiempo asignelo a una variable llamada listasoccer. Se crear� una lista con los elementos scores 
# y teams que son data frames listos para la funci�n rank.teams. Asigna estos data frames a variables 
# llamadas anotaciones y equipos.
listasoccer <- create.fbRanks.dataframes("soccer.csv")
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams
# Con ayuda de la funci�n unique crea un vector de fechas (fecha) que no se repitan y que correspondan a 
# las fechas en las que se jugaron partidos. Crea una variable llamada n que contenga el n�mero de fechas 
# diferentes. Posteriormente, con la funci�n rank.teams y usando como argumentos los data frames anotaciones 
# y equipos, crea un ranking de equipos usando unicamente datos desde la fecha inicial y hasta la pen�ltima
# fecha en la que se jugaron partidos, estas fechas las deber� especificar en max.date y min.date. 
# Guarda los resultados con el nombre ranking.
fecha <- unique(anotaciones$date)
n <- length(fecha)

ranking <- rank.teams(anotaciones, equipos, min.date = fecha[1], max.date = fecha[n-1], silent = T)
# Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana 
# o el resultado es un empate para los partidos que se jugaron en la �ltima fecha del vector de fechas fecha.
# Esto lo puedes hacer con ayuda de la funci�n predict y usando como argumentos ranking y fecha[n] que deber� 
# especificar en date.
predict(ranking, date = fecha[n])