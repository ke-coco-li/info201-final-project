library(dplyr)
library(ggplot2)
library(miscTools)
library(tidyverse)

one_b <- read.csv("data/Metro_MedianRentalPrice_1Bedroom.csv", stringsAsFactors = FALSE)
two_b <- read.csv("data/Metro_MedianRentalPrice_2Bedroom.csv", stringsAsFactors = FALSE)
three_b <- read.csv("data/Metro_MedianRentalPrice_3Bedroom.csv", stringsAsFactors = FALSE)
four_b <- read.csv("data/Metro_MedianRentalPrice_4Bedroom.csv", stringsAsFactors = FALSE)
five_b <- read.csv("data/Metro_MedianRentalPrice_5BedroomOrMore.csv", stringsAsFactors = FALSE)
allHomes <- read.csv("data/Metro_MedianRentalPrice_AllHomes.csv", stringsAsFactors = FALSE)
condo_coop <- read.csv("data/Metro_MedianRentalPrice_CondoCoop.csv", stringsAsFactors = FALSE)
duplex <- read.csv("data/Metro_MedianRentalPrice_DuplexTriplex.csv", stringsAsFactors = FALSE)
mfr <- read.csv("data/Metro_MedianRentalPrice_Mfr5Plus.csv", stringsAsFactors = FALSE)
sfr <- read.csv("data/Metro_MedianRentalPrice_Sfr.csv", stringsAsFactors = FALSE)
studio <- read.csv("data/Metro_MedianRentalPrice_Studio.csv", stringsAsFactors = FALSE)






