# Postwork: Sesión 1

library(tidyverse)

setwd("C:/Users/Aleja/Desktop")

SP1 <- read_csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

?table

# Probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)

FTHG <- SP1 %>% 
  select(FTHG) %>% 
  table()

FTHG/sum(FTHG)
# Probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
FTAG <- SP1 %>% 
  select(FTAG) %>% 
  table()

FTAG/sum(FTAG)
# Probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
FTHG_FTAG <- SP1 %>% 
  select(FTHG,FTAG) %>% 
  table()

FTHG_FTAG/sum(FTHG_FTAG)