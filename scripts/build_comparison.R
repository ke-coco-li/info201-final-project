library(tidyverse)
library(dplyr)

#load datasets and clean them
dataset_sales <- read.csv("~/Desktop/info201-final-project/data/Sale_Prices_State.csv",
                          stringsAsFactors = F)
dataset_rent <- read.csv("~/Desktop/info201-final-project/data/State_MedianRentalPrice_Sfr.csv", 
                         stringsAsFactors = F)
dataset_rent <- dataset_rent %>% select(1, 15:110)
colnames(dataset_rent)[2:97] <- paste0('rent_', colnames(dataset_rent)[2:97])
names(dataset_rent) = sub("X", "", names(dataset_rent))
dataset_rent[is.na(dataset_rent)] <- 0



dataset_sales <- dataset_sales %>% select(2, 38:133)
colnames(dataset_sales)[2:97] <- paste0('sales_', colnames(dataset_sales)[2:97])
names(dataset_sales) = sub("X", "", names(dataset_sales))
dataset_sales[is.na(dataset_sales)] <- 0


newset <- filter(dataset_rent, RegionName == "Texas") %>%
  mutate("2011" = sum(newset[2:13]), 
          "2012" = sum(newset[14:25])/12,
          "2013" = sum(newset[26:37])/12,
          "2014" = sum(newset[38:49])/12,
          "2015" = sum(newset[50:61])/12,
          "2016" = sum(newset[62:73])/12,
          "2017" = sum(newset[74:85])/12,
          "2018" = sum(newset[86:97])/12)
newset <- select(newset, "RegionName", input$year)

saleset <- filter(dataset_sales, RegionName == "Texas") %>%
  mutate("2011" = sum(saleset[2:13])/12, 
         "2012" = sum(saleset[14:25])/12,
         "2013" = sum(saleset[26:37])/12,
         "2014" = sum(saleset[38:49])/12,
         "2015" = sum(saleset[50:61])/12,
         "2016" = sum(saleset[62:73])/12,
         "2017" = sum(saleset[74:85])/12,
         "2018" = sum(saleset[86:97])/12)
saleset <- select(saleset, "RegionName", input$year)


combined <- merge(dataset_sales, dataset_rent, by = c("RegionName"))