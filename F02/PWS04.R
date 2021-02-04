# Postwork Sesión 4
library(tidyverse)
library(rsample)
# Desarrollo
url <- c("https://www.football-data.co.uk/mmz4281/1920/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1718/SP1.csv")

data <- map(url,read_csv)

SP01 <- data %>% 
  map(function(data) data %>% select(Date, HomeTeam, AwayTeam, FTHG, FTAG , FTR)) %>% 
  reduce(rbind)
# Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa 
# y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap, 
# revisa bibliografía en internet para que tengas nociones de este desarrollo.

# Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote 
# X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. 
# Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
FTHG <- SP01 %>% 
  select(FTHG) %>% 
  table()

FTHG <- FTHG/sum(FTHG)

FTAG <- SP01 %>% 
  select(FTAG) %>% 
  table()

FTAG <- FTAG/sum(FTAG)

FTHG_FTAG <- SP01 %>% 
  select(FTHG,FTAG) %>% 
  table()

FTHG_FTAG <- FTHG_FTAG/sum(FTHG_FTAG)

mat <- matrix(, nrow = 9, ncol = 7)

for (i in 1:9) {
  for (k in 1:7) {
    mat[i,k] <- as.matrix(FTHG)[i,1]*as.matrix(FTAG)[k,1]
  }
}

FTHG_FTAG/mat
# Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla 
# del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes
# en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la 
# tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).
set.seed(839287482)

SP01_boot <- bootstraps(SP01,times = 100)

bs <- list()
for (i in 1:100) {
  SP01_b <- as.data.frame(SP01_boot$splits[[i]])
  FTHG_b <- SP01_b %>% 
    select(FTHG) %>% 
    table()
  
  FTHG_b <- FTHG_b/sum(FTHG_b)
  
  FTAG_b <- SP01_b %>% 
    select(FTAG) %>% 
    table()
  
  FTAG_b <- FTAG_b/sum(FTAG_b)
  
  FTHG_FTAG_b <- SP01_b %>% 
    select(FTHG,FTAG) %>% 
    table()
  
  FTHG_FTAG_b <- FTHG_FTAG_b/sum(FTHG_FTAG_b)
  
  mat_b <- matrix(, nrow = nrow(as.matrix(FTHG_b)), ncol = nrow(as.matrix(FTAG_b)))
  
  for (i in 1:nrow(as.matrix(FTHG_b))) {
    for (k in 1:nrow(as.matrix(FTAG_b))) {
      mat_b[i,k] <- as.matrix(FTHG_b)[i,1]*as.matrix(FTAG_b)[k,1]
    }
  }
  
  FTHG_FTAG_b/mat_b
  
  bs[[i]] <- mat_b
  
}


