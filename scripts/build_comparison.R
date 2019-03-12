library(tidyverse)
library(dplyr)
library(ggplot2)

#load datasets and clean them
dataset_sales <- read.csv("data/Sale_Prices_State.csv",
                          stringsAsFactors = F)
dataset_rent <- read.csv("data/State_MedianRentalPrice_Sfr.csv", 
                         stringsAsFactors = F)
#rent datset
dataset_rent <- dataset_rent %>% select(1, 15:110)
names(dataset_rent) = sub("X", "", names(dataset_rent))
dataset_rent[is.na(dataset_rent)] <- 0
#sales dataset
dataset_sales <- dataset_sales %>% select(2, 38:133)
names(dataset_sales) = sub("X", "", names(dataset_sales))
dataset_sales[is.na(dataset_sales)] <- 0