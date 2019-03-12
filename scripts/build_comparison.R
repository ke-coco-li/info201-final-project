library(tidyverse)
library(dplyr)

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


rentset <- filter(dataset_rent, RegionName == "input$state")
rentset <- mutate(rentset, "rent_2011" = sum(rentset[2:13]/12), 
          "rent_2012" = sum(rentset[14:25])/12,
          "rent_2013" = sum(rentset[26:37])/12,
          "rent_2014" = sum(rentset[38:49])/12,
          "rent_2015" = sum(rentset[50:61])/12,
          "rent_2016" = sum(rentset[62:73])/12,
          "rent_2017" = sum(rentset[74:85])/12,
          "rent_2018" = sum(rentset[86:97])/12)
rentset <- select(rentset, "RegionName", "input$year")

salesset <- filter(dataset_sales, RegionName == "Texas")
salesset <- mutate(salesset, "sales_2011" = sum(salesset[2:13])/12, 
                   "sales_2012" = sum(salesset[14:25])/12,
                   "sales_2013" = sum(salesset[26:37])/12,
                   "sales_2014" = sum(salesset[38:49])/12,
                   "sales_2015" = sum(salesset[50:61])/12,
                   "sales_2016" = sum(salesset[62:73])/12,
                   "sales_2017" = sum(salesset[74:85])/12,
                   "sales_2018" = sum(salesset[86:97])/12)
salesset <- select(salesset, "RegionName", "2018")
combined <- merge(rentset, salesset, by = c("RegionName"))