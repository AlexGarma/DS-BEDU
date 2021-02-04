# Postwork Sesión 6

 
# Importa el conjunto de datos match.data.csv a `R` y realiza lo siguiente:
library(tidyverse)
data <- read_csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv") 

# 1. Agrega una nueva columna `sumagoles` que contenga la suma de goles por
# partido.
data_ts <- data %>%
  mutate(sumagoles = home.score + away.score) %>% 
  group_by(date = lubridate::floor_date(as.Date(date), unit = "month")) %>% 
  summarise(promgoles = mean(sumagoles))
# 2. Obtén el promedio por mes de la suma de goles.

# 3. Crea la serie de tiempo del promedio por mes de la suma de goles hasta 
# diciembre de 2019.

# 4. Grafica la serie de tiempo.
data_ts %>%
  ggplot(aes(date, promgoles)) +
  geom_line() +
  geom_point() +
  scale_x_date(date_labels = "%b. %Y")







