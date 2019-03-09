# Geocode city, state: based on the following blog post
# http://www.storybench.org/geocode-csv-addresses-r/
#Using script to get lat and long for Zillow-listed cities


# Use dev version of ggmaps so that you can set the Google Maps API key
# devtools::install_github("dkahle/ggmap")
library(ggmap)
library(dplyr)

# Load and google maps API key (you'll need to get your own to run the script)
source("api-key.R")
register_google(key = googlemaps_key)

# Load the raw data
raw_data <- read.csv("data/Affordability_Wide_2018Q4_Public.csv", stringsAsFactors = F) %>%
  mutate(
    lat = 0,
    long = 0
  )

# Get addresses using the geocode function
raw_data[, c("long", "lat")] <- geocode(raw_data$RegionName)

View(rent_data)
# Filter out for only 'rent affordability' and for only 2018 percentages
rent_data <- raw_data %>%
  select(
    RegionID,
    RegionName,
    SizeRank,
    Index,
    HistoricAverage_1985thru1999,
    X2018.03,
    X2018.06,
    X2018.09,
    X2018.12,
    lat,
    long
  ) %>% filter(
    Index == "Rent Affordability",
    RegionName != "United States"
  ) %>% mutate(
    category = cut(SizeRank,
                   breaks = c(0, 10, 50, 100, Inf),
                   labels = c("Top 10", "Top 50", "Top 100", "Top 300"))
  )
# Write a CSV file containing raw_data to the working directory
write.csv(raw_data, "data/Affordability_Wide_lat_long.csv", row.names = FALSE)
write.csv(rent_data, "data/Affordability_Wide_lat_long_rent_only.csv", row.names = FALSE)
