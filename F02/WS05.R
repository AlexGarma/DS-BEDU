# Reto 1

# Se cree que entre las variables x y y del archivo csv adjunto, podr�a haber una relaci�n m�s o menos lineal. Para tener m�s evidencia sobre esto lleve a cabo lo siguiente:
library(tidyverse)
# Realice el gr�fico de dispersi�n de los datos
data <- read_csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-05/Reto-01/datoslineal.csv")

data %>% 
  ggplot(aes(x,y))+
  geom_point()+
  stat_smooth(method = "lm", se = F)
# Ajuste un modelo de regresi�n lineal simple a los datos, muestre un resumen del modelo ajustado y trace la recta de regresi�n estimada junto con el gr�fico de dispersi�n
lm <- lm(y~x,data)

summary(lm)
# Obtenga algunas gr�ficas de diagn�stico y diga si es razonable suponer para los errores aleatoriedad, normalidad y varianza constante.
data %>% 
  mutate(res = lm$res, fitted = lm$fitted.values) %>% 
  ggplot(aes(x = fitted, y = res))+
  geom_point()

data %>% 
  mutate(res = lm$res, fitted = lm$fitted.values) %>% 
  ggplot(aes(x = fitted, y = y))+
  geom_point()

data %>% 
  mutate(res = lm$res, fitted = lm$fitted.values) %>% 
  ggplot(aes(sample = res))+
  stat_qq()+
  stat_qq_line()

shapiro.test(lm$residuals)

mean(lm$residuals)
# Los supuestos son validos 

#Reto 2 
# Carga los paquetes ggplot2 y e1071; observe algunas caracter�sticas del data frame con las funciones tail y dim. Obtenga el gr�fico de dispersi�n de los datos diferenciando las dos clases.
data <- read_csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-05/Reto-02/datosclases.csv")

data %>% 
  mutate(y = as.factor(y)) %>% 
  ggplot(aes(x = x.1, y = x.2, color = y))+
  geom_point()+
  facet_wrap(~y)
# Genera de manera aleatoria un vector de �ndices para filtrar un conjunto de entrenamiento a partir del conjunto de datos dado. Con ayuda de las funciones tune y svm ajuste m�quinas de vectores de soporte con un kernel radial a los datos de entrenamiento, para valores del par�metro cost igual a 0.1, 1, 10, 100, 1000 y valores del par�metro gamma igual a 0.5, 1, 2, 3, 4. Obtenga un resumen de los resultados.
idx <- caret::createDataPartition(data$y,p = .75, list = F, times = 1)
train <- data[idx,] 
test <- data[-idx,]

train %>% 
  ggplot(aes(x = x.1,y = x.2, color = as.factor(y)))+
  geom_point()

test %>% 
  ggplot(aes(x = x.1,y = x.2, color = as.factor(y)))+
  geom_point()

tune.rad <- tune(svm, data ~ ., data = unlist(data) ,
                 kernel = "radial",
                 ranges = list(cost = c(0.1, 1, 10, 100, 1000),
                               gamma = c(0.5, 1, 2, 3, 4)))

best <- svm(data~.,  data = as.data.frame(train),
            kernel = "radial",
            cost = 100,
            gamma = 2
)
# Con el modelo que tuvo el mejor desempe�o en el paso anterior realiza clasificaci�n con la funci�n predict y el conjunto de datos de prueba. Muestre la matriz de confusi�n.




