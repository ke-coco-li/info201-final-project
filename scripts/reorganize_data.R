library(dplyr)
library(ggplot2)
library(miscTools)

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


median_based_on_year <- function(data) {
  data %>% 
    filter(grepl("NY", RegionName)) %>%
    mutate("2010" = rowMedians(select(., contains("2010")), na.rm = TRUE),
           "2011" = rowMedians(select(., contains("2011")), na.rm = TRUE),
           "2012" = rowMedians(select(., contains("2012")), na.rm = TRUE),
           "2013" = rowMedians(select(., contains("2013")), na.rm = TRUE),
           "2014" = rowMedians(select(., contains("2014")), na.rm = TRUE),
           "2015" = rowMedians(select(., contains("2015")), na.rm = TRUE),
           "2016" = rowMedians(select(., contains("2016")), na.rm = TRUE),
           "2017" = rowMedians(select(., contains("2017")), na.rm = TRUE),
           "2018" = rowMedians(select(., contains("2018")), na.rm = TRUE),
           "2019" = rowMedians(select(., contains("2019")), na.rm = TRUE)) %>%
    select(RegionName, "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019")
  data
}



