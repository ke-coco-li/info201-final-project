#Final Project: server script

# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)

#Read in data
source("./scripts/build_map.R")
source("./scripts/reorganize_data.R")

afford_data <- read.csv("data/Affordability_Wide_lat_long_rent_only.csv",
                        stringsAsFactors = F)

# Starting shinyServer
server <- shinyServer(function(input, output) {
  output$affordability_map <- renderLeaflet({
    return(build_map1(afford_data, input$percentage, input$city_size))
  })
  
  output$select_city <- renderUI({
    state <- input$chosen_state
    cities <- one_b %>% filter(grepl(state, RegionName))
    selectInput("chosen_city",
                label = "State of Your Interest",
                choices = cities$RegionName)
  })
  
  output$trend_plot <- renderPlot({
    median_based_on_year <- function(data) {
      r_data <- data %>% 
        filter(input$chosen_city == RegionName) %>%
        select(-SizeRank)
      colnames(r_data) <- gsub("X", "", colnames(r_data))
      colnames(r_data) <- gsub("[.]", "-", colnames(r_data))
      r_data
    }
    p <- ggplot()
    if ("All Homes" %in% input$home_types) {
      home_data <- median_based_on_year(allHomes)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "All Homes", group = 1))
    }
    if ("Studio" %in% input$home_types) {
      home_data <- median_based_on_year(studio)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Studio", group = 1))
    }
    if ("One Bedroom" %in% input$home_types) {
      home_data <- median_based_on_year(one_b)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "One Bedroom", group = 1))
    }
    if ("Two Bedrooms" %in% input$home_types) {
      home_data <- median_based_on_year(two_b)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Two Bedroom", group = 1))
    }
    if ("Three Bedrooms" %in% input$home_types) {
      home_data <- median_based_on_year(three_b)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Three Bedroom", group = 1))
    }
    if ("Four Bedrooms" %in% input$home_types) {
      home_data <- median_based_on_year(four_b)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Four Bedroom", group = 1))
    }
    if ("Five Bedrooms or More" %in% input$home_types) {
      home_data <- median_based_on_year(five_b)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Five Bedroom+", group = 1))
    }
    if ("Condo And Co-op" %in% input$home_types) {
      home_data <- median_based_on_year(condo_coop)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Condo/Co-op", group = 1))
    }
    if ("Duplex And Triplex" %in% input$home_types) {
      home_data <- median_based_on_year(duplex)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Duplex/Triplex", group = 1))
    }
    if ("Single Family Residence" %in% input$home_types) {
      home_data <- median_based_on_year(sfr)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "SFR", group = 1))
    }
    if ("Multi-family Residence (5+)" %in% input$home_types) {
      home_data <- median_based_on_year(mfr)
      home_data2 <- melt(home_data, id = "RegionName")
      home_data2$variable <- as.Date(paste0(home_data2$variable,"-01"), format = "%Y-%m-%d")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "MFR", group = 1))
    }
    p + labs(x = "year", y = "median monthly rent", title = "Monthly Rent vs. Time")
  })
})