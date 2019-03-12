library(tidyverse)
library(dplyr)
library(plotly)
library(ggplot2)
#load datasets and clean them
dataset_sales <- read.csv("~/Desktop/info201-final-project/data/Sale_Prices_State.csv",
                          stringsAsFactors = F)
dataset_rent <- read.csv("~/Desktop/info201-final-project/data/State_MedianRentalPrice_Sfr.csv", 
                         stringsAsFactors = F)
#rent datset
dataset_rent <- dataset_rent %>% select(1, 15:110)
names(dataset_rent) = sub("X", "", names(dataset_rent))
dataset_rent[is.na(dataset_rent)] <- 0
#sales dataset
dataset_sales <- dataset_sales %>% select(2, 38:133)
names(dataset_sales) = sub("X", "", names(dataset_sales))
dataset_sales[is.na(dataset_sales)] <- 0


rentset <- filter(dataset_rent, RegionName == "Texas")
rentset <- mutate(rentset, "2011" = sum(rentset[2:13]/12), 
          "2012" = sum(rentset[14:25])/12,
          "2013" = sum(rentset[26:37])/12,
          "2014" = sum(rentset[38:49])/12,
          "2015" = sum(rentset[50:61])/12,
          "2016" = sum(rentset[62:73])/12,
          "2017" = sum(rentset[74:85])/12,
          "2018" = sum(rentset[86:97])/12)
rentset <- select(rentset, "RegionName", "2016")

salesset <- filter(dataset_sales, RegionName == "Texas")
salesset <- mutate(salesset, "2011" = sum(salesset[2:13])/12, 
                   "2012" = sum(salesset[14:25])/12,
                   "2013" = sum(salesset[26:37])/12,
                   "2014" = sum(salesset[38:49])/12,
                   "2015" = sum(salesset[50:61])/12,
                   "2016" = sum(salesset[62:73])/12,
                   "2017" = sum(salesset[74:85])/12,
                   "2018" = sum(salesset[86:97])/12)
salesset <- select(salesset, "RegionName", "2016")


