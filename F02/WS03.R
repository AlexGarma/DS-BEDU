# Sesion 03. Análisis Exploratorio de Datos (AED o EDA) con R

# Reto 1 Altura de los alumnos
library(tidyverse)
# Este ejemplo aunque es básico, servirá para realizar una comparación entre las funciones hist() y ggplot, los dos útiles, comparalos y decide cual es de tu agrado de acuerdo a los requerimientos.
# 
# Carga el data set BD_Altura_Alunos.csv (Hint: Si tienes algún inconveniente con los datos, lee sobre el argumento sep de la función read.csv)
altura <- read_delim("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-03/Reto-01/BD_Altura_Alunos.csv",";")
# Realiza el histograma con la función hist(), nativa de R
hist(altura$Altura)
# Ahora realiza el histograma con la función ggplot. (Recuerda que debes instalar el paquete ggplot2)
altura %>% 
  ggplot(aes(x = Altura))+
  geom_histogram(color = "white", binwidth = 4)
# Reflexiona sobre el ejercicio y saca tus conclusiones sobre cuál es el método que más te convence.

# Reto 2 Estadísticos de la NBA
nba <- read_csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-03/Reto-02/players_stats.csv")
# Generar un histograma de los minuntos totales (MIN), de los jugadores y agregar una línea donde se muestre la media (Hint: para agregar la línea que muestre la media consulta la documentación sobre geom_vline y el argumento xintercept)
nba %>% 
  ggplot(aes(MIN))+
  geom_histogram(color = "white")+
  geom_vline(xintercept = mean(nba$MIN))
# Generar un histograma de edad (Age) y agregar una línea con la media
nba %>% 
  ggplot(aes(Age))+
  geom_histogram(color = "white")+
  geom_vline(xintercept = mean(nba$Age))
# Hacer un scatterplot de las variables Weight y Height y observar la correlacón que existe entre ambas variables (1 sola gráfica)
nba %>% 
  ggplot(aes(x = Weight, y = Height))+
  geom_point()
# Utiliza la función which.max para saber quién es el jugador más alto, una vez hecho esto, presenta los resultados en una leyenda que diga "El jugador más alto es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.
nba %>%
  select(Name,Height) %>% 
  top_n(1,Height)
# Utiliza la función which.min para saber quién es el jugador más bajito, una vez hecho esto, presenta los resultados en una leyenda que diga "El jugador más bajito es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.
nba %>%
  select(Name,Height) %>% 
  top_n(1,desc(Height))
# ¿Cuál es la altura promedio?, representa el resultado en una frase que diga: "La altura promedio es: ALTURA"
nba %>%
  select(Name,Height) %>% 
  summarise(mean = mean(Height,na.rm = T))
# Generar un scatterplot donde se representen l
# as Asistencias totales (AST.TOV) vs Puntos (PTS), además has un face wrap con la posición (Pos).
nba %>% 
  ggplot(aes(x =`AST/TOV`,y= PTS))+
  geom_point()+
  facet_wrap(~Pos)

# RETO 3. Series de tiempo

library(forecast)
data(AirPassengers)

AP <- AirPassengers%>% 
  xts::as.xts() %>% 
  decompose()