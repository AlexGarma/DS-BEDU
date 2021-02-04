
library(tidyverse)

# Reto 1: Lectura y escritura de datos

netflix <- read_csv("https://raw.githubusercontent.com/ecoronadoj/Sesion_1/main/Data/netflix_titles.csv")

dim(netflix)
class(netflix)

net.2015 <- netflix %>% 
  filter(release_year>2015)

write_csv(net.2015,"res.netflix.csv")

# Reto 2 : Operaciones con data frames
# 
# Utiliza el data frame de ventas de libros por Amazon y realiza las siguientes actividades:
#   
#  Almacenalo en un data frame que se llame amazon.best


amazon.best <- read_csv("https://raw.githubusercontent.com/ecoronadoj/Sesion_1/main/Data/bestsellers%20with%20categories.csv")

tAmazon <- amazon.best %>% 
  t() %>% 
  as.data.frame()

colnames(tAmazon)<- amazon.best$Name

# ¿Cúal es el libro de menor y mayor precio?
amazon.best %>% 
  arrange(Price)

amazon.best %>% 
  arrange(desc(Price))
# Reto 3. Loops
# 
# 1. Genera un vector de 44 entradas (aleatorias) llamado ran
ran <- vector()
for (i in 1:44) {
  ran[i]<- runif(1)
}

# 2. Escribe un loop que eleve al cubo las primeras 15 entradas y les sume 12
res <- ran
for (i in 1:15) {
  res[i] <- ran[i]^3 +12
}
# 3. Guarda el resultado en un data frame, donde la primera columna sea el número 
# aleatorio y la segunda el resultado, nómbralo df.al
df.al <- tibble(ran,res)