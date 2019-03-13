#Final Project: server script

# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)
library(tidyverse)

#Read in data
source("./scripts/build_map.R")
#source("./scripts/reorganize_data.R")
source("./scripts/build_comparison.R")

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
  
  output$plot <- renderPlot({
    median_based_on_year <- function(data) {
      r_data <- data %>% 
        filter(input$chosen_city == RegionName) %>%
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
      r_data
    }
    p <- ggplot()
    if ("All Homes" %in% input$home_types) {
      home_data <- median_based_on_year(allHomes)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "All Homes", group = 1))
    }
    if ("Studio" %in% input$home_types) {
      home_data <- median_based_on_year(studio)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Studio", group = 1))
    }
    if ("One Bedroom" %in% input$home_types) {
      home_data <- median_based_on_year(one_b)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "One Bedroom", group = 1))
    }
    if ("Two Bedrooms" %in% input$home_types) {
      home_data <- median_based_on_year(two_b)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Two Bedroom", group = 1))
    }
    if ("Three Bedrooms" %in% input$home_types) {
      home_data <- median_based_on_year(three_b)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Three Bedroom", group = 1))
    }
    if ("Four Bedrooms" %in% input$home_types) {
      home_data <- median_based_on_year(four_b)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Four Bedroom", group = 1))
    }
    if ("Five Bedrooms or More" %in% input$home_types) {
      home_data <- median_based_on_year(five_b)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Five Bedroom+", group = 1))
    }
    if ("Condo And Co-op" %in% input$home_types) {
      home_data <- median_based_on_year(condo_coop)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Condo/Co-op", group = 1))
    }
    if ("Duplex And Triplex" %in% input$home_types) {
      home_data <- median_based_on_year(duplex)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "Duplex/Triplex", group = 1))
    }
    if ("Single Family Residence" %in% input$home_types) {
      home_data <- median_based_on_year(sfr)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "SFR", group = 1))
    }
    if ("Multi-family Residence (5+)" %in% input$home_types) {
      home_data <- median_based_on_year(mfr)
      home_data2 <- melt(home_data, id = "RegionName")
      p <- p + geom_line(data = home_data2, aes(x = variable, y = value, col = "MFR", group = 1))
    }
    p + labs(x = "year", y = "median monthly rent", title = "Monthly Rent vs. Time")
  })
  
  output$rentplot <- renderPlot({
    rentset <- filter(dataset_rent, RegionName == input$state)
    rentset <- mutate(rentset, "2011" = round(sum(rentset[2:13])/12), 
                      "2012" = round(sum(rentset[14:25])/12),
                      "2013" = round(sum(rentset[26:37])/12),
                      "2014" = round(sum(rentset[38:49])/12),
                      "2015" = round(sum(rentset[50:61])/12),
                      "2016" = round(sum(rentset[62:73])/12),
                      "2017" = round(sum(rentset[74:85])/12),
                      "2018" = round(sum(rentset[86:97])/12))
    rentset <- select(rentset, "RegionName", "2012", "2013", "2014", "2015", "2016", "2017", "2018")
    return(plot(x= colnames(rentset), y= rentset, type = "b", col = "blue", 
                xlab = "Year", ylab = "Price in $", main = "Average Monthly Rent Price of Homes") +
             text(x= colnames(rentset), y = rentset[1:7], paste0("$", rentset), pos = 3) +
             text(x= colnames(rentset[8]), y = rentset[8], paste0("$", rentset$`2018`), pos = 1))
  })
  
  output$salesplot <- renderPlot({
    salesset <- filter(dataset_sales, RegionName == input$state)
    salesset <- mutate(salesset, "2011" = round(sum(salesset[2:13])/12), 
                       "2012" = round(sum(salesset[14:25])/12),
                       "2013" = round(sum(salesset[26:37])/12),
                       "2014" = round(sum(salesset[38:49])/12),
                       "2015" = round(sum(salesset[50:61])/12),
                       "2016" = round(sum(salesset[62:73])/12),
                       "2017" = round(sum(salesset[74:85])/12),
                       "2018" = round(sum(salesset[86:97])/12))
    salesset <- select(salesset, "RegionName", "2012", "2013", "2014", "2015", "2016", "2017", "2018")
    return(plot(x= colnames(salesset), y= salesset, type = "b", col = "red",
                xlab = "Year", ylab = "Price in $", main = "Average Sale Price of Homes")+
             text(x= colnames(salesset), y = salesset[1:7], paste0("$", salesset), pos = 4) +
             text(x= colnames(salesset[8]), y = salesset[8], paste0("$", salesset$`2018`), pos = 2))
  })
  
  output$month <- renderText({
    salesset <- filter(dataset_sales, RegionName == input$state)
    salesset <- mutate(salesset, "2011" = round(sum(salesset[2:13])/12), 
                       "2012" = round(sum(salesset[14:25])/12),
                       "2013" = round(sum(salesset[26:37])/12),
                       "2014" = round(sum(salesset[38:49])/12),
                       "2015" = round(sum(salesset[50:61])/12),
                       "2016" = round(sum(salesset[62:73])/12),
                       "2017" = round(sum(salesset[74:85])/12),
                       "2018" = round(sum(salesset[86:97])/12))
    salesset <- select(salesset, "RegionName", "2012", "2013", "2014", "2015", "2016", "2017", "2018")
    rentset <- filter(dataset_rent, RegionName == input$state)
    rentset <- mutate(rentset, "2011" = round(sum(rentset[2:13])/12), 
                      "2012" = round(sum(rentset[14:25])/12),
                      "2013" = round(sum(rentset[26:37])/12),
                      "2014" = round(sum(rentset[38:49])/12),
                      "2015" = round(sum(rentset[50:61])/12),
                      "2016" = round(sum(rentset[62:73])/12),
                      "2017" = round(sum(rentset[74:85])/12),
                      "2018" = round(sum(rentset[86:97])/12))
    rentset <- select(rentset, "RegionName", "2012", "2013", "2014", "2015", "2016", "2017", "2018")
    paste(round(salesset[input$year]/rentset[input$year]))
  })
})