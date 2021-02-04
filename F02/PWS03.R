# Postwork Sesión 3

# Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el número de goles que anotan en un partido el equipo de casa o el equipo visitante.
url <- c("https://www.football-data.co.uk/mmz4281/1920/SP1.csv",
"https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
"https://www.football-data.co.uk/mmz4281/1718/SP1.csv")

data <- map(url,read_csv)

SP01 <- data %>% 
  map(function(data) data %>% select(Date, HomeTeam, AwayTeam, FTHG, FTAG , FTR)) %>% 
  reduce(rbind)
# Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

#   La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
FTHG <- SP01 %>% 
  select(FTHG) %>% 
  table()

FTHG <- FTHG/sum(FTHG)
# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
FTAG <- SP01 %>% 
  select(FTAG) %>% 
  table()

FTAG <- FTAG/sum(FTAG)
# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
FTHG_FTAG <- SP01 %>% 
  select(FTHG,FTAG) %>% 
  table()

round(FTHG_FTAG/ sum(FTHG_FTAG),2)
# Realiza lo siguiente:
#   Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
FTHG %>% 
  as.tibble() %>% 
  ggplot(aes(x = ., y = n))+
  geom_bar(stat = "identity")
# Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
FTAG %>% 
  as.tibble() %>% 
  ggplot(aes(x = ., y = n))+
  geom_bar(stat = "identity")
# Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.
FTHG_FTAG <- as.matrix(FTHG_FTAG/sum(FTHG_FTAG))

FTHG_FTAG %>% heatmap()