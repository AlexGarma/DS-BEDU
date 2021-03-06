# Sesion 03. An�lisis Exploratorio de Datos (AED o EDA) con R

# Reto 1 Altura de los alumnos
library(tidyverse)
# Este ejemplo aunque es b�sico, servir� para realizar una comparaci�n entre las funciones hist() y ggplot, los dos �tiles, comparalos y decide cual es de tu agrado de acuerdo a los requerimientos.
# 
# Carga el data set BD_Altura_Alunos.csv (Hint: Si tienes alg�n inconveniente con los datos, lee sobre el argumento sep de la funci�n read.csv)
altura <- read_delim("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-03/Reto-01/BD_Altura_Alunos.csv",";")
# Realiza el histograma con la funci�n hist(), nativa de R
hist(altura$Altura)
# Ahora realiza el histograma con la funci�n ggplot. (Recuerda que debes instalar el paquete ggplot2)
altura %>% 
  ggplot(aes(x = Altura))+
  geom_histogram(color = "white", binwidth = 4)
# Reflexiona sobre el ejercicio y saca tus conclusiones sobre cu�l es el m�todo que m�s te convence.

# Reto 2 Estad�sticos de la NBA
nba <- read_csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-03/Reto-02/players_stats.csv")
# Generar un histograma de los minuntos totales (MIN), de los jugadores y agregar una l�nea donde se muestre la media (Hint: para agregar la l�nea que muestre la media consulta la documentaci�n sobre geom_vline y el argumento xintercept)
nba %>% 
  ggplot(aes(MIN))+
  geom_histogram(color = "white")+
  geom_vline(xintercept = mean(nba$MIN))
# Generar un histograma de edad (Age) y agregar una l�nea con la media
nba %>% 
  ggplot(aes(Age))+
  geom_histogram(color = "white")+
  geom_vline(xintercept = mean(nba$Age))
# Hacer un scatterplot de las variables Weight y Height y observar la correlac�n que existe entre ambas variables (1 sola gr�fica)
nba %>% 
  ggplot(aes(x = Weight, y = Height))+
  geom_point()
# Utiliza la funci�n which.max para saber qui�n es el jugador m�s alto, una vez hecho esto, presenta los resultados en una leyenda que diga "El jugador m�s alto es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.
nba %>%
  select(Name,Height) %>% 
  top_n(1,Height)
# Utiliza la funci�n which.min para saber qui�n es el jugador m�s bajito, una vez hecho esto, presenta los resultados en una leyenda que diga "El jugador m�s bajito es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.
nba %>%
  select(Name,Height) %>% 
  top_n(1,desc(Height))
# �Cu�l es la altura promedio?, representa el resultado en una frase que diga: "La altura promedio es: ALTURA"
nba %>%
  select(Name,Height) %>% 
  summarise(mean = mean(Height,na.rm = T))
# Generar un scatterplot donde se representen l
# as Asistencias totales (AST.TOV) vs Puntos (PTS), adem�s has un face wrap con la posici�n (Pos).
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