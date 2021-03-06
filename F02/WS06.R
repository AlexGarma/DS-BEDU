# Reto 1. Simulaci�n de un proceso AR(1)

# Simula un proceso AR(1) de la forma x[t] = 0.5 * x[t-1] + w[t] para t = 1, 2, ..., 200 y muestra gr�ficamente la serie de tiempo obtenida
AR <- arima.sim(n = 200, model = list(order = c(1,0,0),ar = 0.5))
# Obt�n el correlograma y el correlograma parcial del proceso AR(1) simulado
plot.ts(AR)
acf(AR,lag.max = 12)
pacf(AR,lag.max = 12)
# Ajusta un modelo autorregresivo a la serie simulada utilizando la funci�n ar, observa el orden del modelo y el par�metro estimado (los par�metros estimados)
ar(AR)

# Reto 2
# Realiza la siguiente simulaci�n con las siguientes caracter�sticas: n = 1000 valores de un proceso ARIMA(1, 1, 1) con par�metros ar = 0.6 y ma = 0.2
AR <- arima.sim(n = 1000, model = list(order = c(1,1,1),ar = .6,ma = .2))
# Ajusta un modelo Arima a la serie simulada para estimar los par�metros y observe las estimaciones de los par�metros
model <- ar(AR)
# Obt�n el correlograma de los residuales del ajuste
acf(AR,lag.max = 12)
pacf(AR,lag.max = 12)
# Realiza tres predicciones con ayuda del modelo ajustado y la funci�n predict
predict(model)

# Reto 3
# Crea un data frame para el Barcelona que indique el n�mero de goles anotados en cada fecha que ha jugado.
data <- read_csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Reto-03/soccer.csv")

barca <- data %>% 
  filter(home.team == "Barcelona") %>% 
  group_by(date) %>% 
  summarise(team = "Barcelona",goals = sum(home.score)) %>% 
  rbind(
    data %>% 
      filter(away.team == "Barcelona") %>% 
      group_by(date) %>% 
      summarise(team = "Barcelona", goals = sum(away.score))
  ) %>% 
  arrange(date)
# Obt�n un data frame que indique el promedio de goles anotados en cada mes que ha jugado
barca <- barca %>% 
  group_by(month = month(date)) %>% 
  summarise(team = "Barcelona",mean_goals = mean(goals))
# Crea una serie de tiempo mensual para el n�mero promedio de goles anotados por el Barcelona
barca %>% 
  ggplot(aes(x = month, y = mean_goals))+
  geom_path()
# Realiza los pasos 1 a 3 para el Real Madrid
rm <- data %>% 
  filter(home.team == "Real Madrid") %>% 
  group_by(date) %>% 
  summarise(team = "Real Madrid",goals = sum(home.score)) %>% 
  rbind(
    data %>% 
      filter(away.team == "Real Madrid") %>% 
      group_by(date) %>% 
      summarise(team = "Real Madrid", goals = sum(away.score))
  ) %>% 
  arrange(date)

rm <- rm %>% 
  group_by(month = month(date)) %>% 
  summarise(team = "Real Madrid",mean_goals = mean(goals))
# Muestra en una misma imagen las gr�ficas de las series de tiempo anteriores
barca %>% 
  rbind(rm) %>% 
  ggplot(aes(x = month ,y = mean_goals, color = team))+
  geom_path()
  