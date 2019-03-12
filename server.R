#Final Project: server script

# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)
library(tidyverse)

#Read in data
source("./scripts/build_map.R")
source("./scripts/reorganize_data.R")
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
                label = "Choose A Metro City of Your Interest",
                choices = cities$RegionName)
  })
  
  output$trend_plot <- renderPlot({
    reformat_colnames <- function(data) {
      r_data <- data %>% 
        filter(input$chosen_city == RegionName) %>%
        select(-SizeRank)
      colnames(r_data) <- gsub("X", "", colnames(r_data))
      colnames(r_data) <- gsub("[.]", "-", colnames(r_data))
      r_data
    }
    add_line <- function(data, colname) {
      if (nrow(data) != 0) {
        data2 <- melt(data, id = "RegionName")
        data2$variable <- as.Date(paste0(data2$variable,"-01"), format = "%Y-%m-%d")
        geom_line(data = data2, aes(x = variable, y = value, col = colname, group = 1))
      }
    }
    p <- ggplot()
    if ("All Homes" %in% input$home_types) {
      home_data <- reformat_colnames(allHomes)
      p <- p + add_line(home_data, "All Homes")
    }
    if ("Studio" %in% input$home_types) {
      home_data <- reformat_colnames(studio)
      p <- p + add_line(home_data, "Studio")
    }
    if ("One Bedroom" %in% input$home_types) {
      home_data <- reformat_colnames(one_b)
      p <- p + add_line(home_data, "One Bedroom")
    }
    if ("Two Bedrooms" %in% input$home_types) {
      home_data <- reformat_colnames(two_b)
      p <- p + add_line(home_data, "Two Bedrooms")
    }
    if ("Three Bedrooms" %in% input$home_types) {
      home_data <- reformat_colnames(three_b)
      p <- p + add_line(home_data, "Three Bedrooms")
    }
    if ("Four Bedrooms" %in% input$home_types) {
      home_data <- reformat_colnames(four_b)
      p <- p + add_line(home_data, "Four Bedrooms")
    }
    if ("Five Bedrooms or More" %in% input$home_types) {
      home_data <- reformat_colnames(five_b)
      p <- p + add_line(home_data, "Five Bedrooms+")
    }
    if ("Condo And Co-op" %in% input$home_types) {
      home_data <- reformat_colnames(condo_coop)
      p <- p + add_line(home_data, "Condo/Co-op")
    }
    if ("Duplex And Triplex" %in% input$home_types) {
      home_data <- reformat_colnames(duplex)
      p <- p + add_line(home_data, "Duplex/Triplex")
    }
    if ("Single Family Residence" %in% input$home_types) {
      home_data <- reformat_colnames(sfr)
      p <- p + add_line(home_data, "SFR")
    }
    if ("Multi-family Residence (5+)" %in% input$home_types) {
      home_data <- reformat_colnames(mfr)
      p <- p + add_line(home_data, "MFR")
    }
    p + labs(x = "year", y = "median monthly rent", title = "Monthly Rent vs. Time", colour = "Home types")
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
         xlab = "Year", ylab = "Price in $", main = "Average Monthly Rent Price") +
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
})