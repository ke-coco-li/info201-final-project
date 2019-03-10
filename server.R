#Final Project: server script

# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)

#Read in data
source("./scripts/build_map.R")
source("./scripts/reorganize_data.R")

afford_data <- read.csv("data/Affordability_Wide_lat_long_rent_only.csv",
                        stringsAsFactors = F)

# Starting shinyServer
shinyServer(function(input, output) {
  output$affordability_map <- renderLeaflet({
    return(build_map1(afford_data, input$percentage, input$city_size))
  })
  
  output$select_city <- renderUI({
    state <- get(input$chosen_state)
    cities <- one_b %>% filter(grepl(state, RegionName))
    selectInput(cities$RegionName)
  })
  
  output$plot <- renderPlot({
    
  })
})