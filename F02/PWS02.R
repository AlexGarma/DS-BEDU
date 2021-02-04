library(tidyverse)
library(lubridate)

setwd("C:/Users/Aleja/Desktop")

url <- c("https://www.football-data.co.uk/mmz4281/1920/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1718/SP1.csv")

raw_SP01 <- map(url,read_csv)

SP01 <- data.frame()

for (i in 1:length(raw_SP01)) {
  SP01 <- raw_SP01 %>% 
    purrr::pluck(i) %>%
    select(Date, HomeTeam, AwayTeam, FTHG, FTAG , FTR) %>% 
    rbind(SP01)
}

SP01 <- SP01 %>% 
  mutate(Date = dmy(Date)) %>% 
  glimpse()