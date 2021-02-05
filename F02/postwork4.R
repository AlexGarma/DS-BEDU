# Postwork 4
# Sesion 4 
# Autor: Equipo 5

#Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa 
#y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap, 
#revisa bibliografía en internet para que tengas nociones de este desarrollo.

# 1.- Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), 
#y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al 
#dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
library(dplyr)
library(reshape2)
     #Descargamos los datos y construimos el dataframe a utilizar
files <- c("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
           "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
           "https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
    
data <- lapply(files, read.csv)
data <- lapply(data, select,c(FTHG, FTAG))
data <- do.call(rbind, data)
     #Obtenemos la tabla de frecuencias 
frecuencias <- table(data)
     #Obtenemos las probabilidades de p(x), p(y) y p(x,y) respectivamente
px <- apply(frecuencias, 1, function(x){sum(x)/sum(frecuencias)})
py <- apply(frecuencias, 2, function(x){sum(x)/sum(frecuencias)})
pxy <- frecuencias/sum(frecuencias)
     #Obtenemos los cocientes p(x,y)/p(x)*p(y)
p_xy <- as.table(matrix(rep(0,63),9,7))
dimnames(p_xy)<-list(0:8,0:6)
for(j in 1:7){
  for (i in 1:9) {
    p_xy[i,j] <- (pxy[i,j]/(px[i]*py[j])) 
  }
}
    #Imprimimos en consola los cocientes
p_xy
    #Convertimos a dataframe y extraemos los cocientes en un vector que usaremos en la tecnica de Bootstrap
p_xy <- as.data.frame(p_xy) 
p_xy <- p_xy$Freq
p_xy

# 2.-Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto 
#anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla 
#anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, 
#son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).
     
    #Replicamos los datos con la tecnica de Bootstrap y con remplazo
bootstrap <- replicate(n = 100000, sample(p_xy, replace = TRUE))
bootstrap <- as.data.frame(t(bootstrap))
#graficamos los histogramas
n <- 8 # El numero del histograma que deseamos realizar
hist(bootstrap[,n], breaks = 10)
#No es posible asegurar la dependencia ya que en gran parte de los datos el cociente es 0 y afecta al remuestreo.
