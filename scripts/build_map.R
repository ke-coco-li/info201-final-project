# BuildMap file: function that returns a plotly map
library(dplyr)
library(leaflet)

#Build Map
build_map1 <- function(filtered_data, afford_perc, city_rank) {
  
  #inputs
  #afford_percent <- afford_perc
  #cit_rank <- city_rank
  #test
  
  #filter data
  specific_data <- filtered_data %>% filter(
    SizeRank <= city_rank & X2018.12 <= afford_perc
  )
  
  #convert rent affordability from numeric to categorical
  lower_range <- (afford_perc - min(specific_data$X2018.12)) * .25 +
    min(specific_data$X2018.12)
  upper_range <- (afford_perc - min(specific_data$X2018.12)) * .75 +
    min(specific_data$X2018.12)
  
  leaflet_data <- specific_data %>% mutate(
    afford_rank = cut(X2018.12,
                      breaks = c(.15,lower_range,
                                 upper_range, Inf),
                      labels = c("Most Affordable",
                                 "Average Affordability",
                                 "Least Affordable")
    )
  )

  # Custom color for rent affordability breakdown
  palete_fn <- colorFactor(palette = "Spectral",
                           domain = leaflet_data$afford_rank,
                           reverse = TRUE)
  #print(lower_range)
  #print(upper_range)
  # Create interactive map
  map_rent <- leaflet(data = leaflet_data) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -98.583, lat = 40.833, zoom = 3.25) %>%
    addCircleMarkers(
      lat = ~lat,
      lng = ~long,
      label = ~ paste(
        "City:", RegionName, "|",
        "City Size Rank:", as.character(SizeRank), "|",
        "Rent Affordability:", as.character(round(X2018.12, 3))
      ),
      stroke = FALSE,
      color = ~ palete_fn(afford_rank),
      fillOpacity = .6
    ) %>%
    addLegend(
      position = "bottomleft",
      title = "Rent Ranking",
      pal = palete_fn,
      values = ~afford_rank,
      opacity = .5
    ) %>%
    addControl("Required Share of Income Spent on Rent (Median)",
               position = "topright")
  
}

