# Sesion 2. Manipulación de datos en R
# 
# Reto 1. Medidas de tendencia central

set.seed(134)
x <- round(rnorm(1000, 175, 6), 1)

# Calcule, la media, mediana y moda de los valores en x
mean(x)
median(x)

modes <- function(x) {
  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  ux[tab == max(tab)]
}

modes(x)
# Obtenga los deciles de los números en x
x1 <- x %>% 
  as.tibble() %>%
  skimr::skim_without_charts()
  
# Encuentre la rango intercuartílico, la desviación estándar y varianza muestral de las mediciones en x
iq <- 179-171
sd(x)
var(x)

# Reto 2. Características de los objetos y funciones
mtcars <- mtcars

mtcars %>% 
  str()

mtcars %>% 
  summary()

mtcars() %>% 
  head

mtcars %>% 
  View()

# Crea una función que calcule la mediana de un conjuntos de valores, sin utilizar la función median
my_median <- function(x){
  if (length(x) %% 2 == 0) {
    x <- sort(x)
    mean(x[c(length(x)/2,length(x)/2+1)])
  }
  else{
    x <- sort(x)
    x[ceiling(length(x)/2)]
  }
}

# Reto 3. Lectura de datos y uso de dplyr
url <- c("https://www.football-data.co.uk/mmz4281/1718/D1.csv",
         "https://www.football-data.co.uk/mmz4281/1819/D1.csv",
         "https://www.football-data.co.uk/mmz4281/1920/D1.csv",
         "https://www.football-data.co.uk/mmz4281/2021/D1.csv")
data <- map(url,read_csv)

data <- map(data,function(data) data %>% 
      select(Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)) %>%
      reduce(rbind)




