library(dplyr)
library(ggplot2)
library(miscTools)
library(tidyverse)

source("scripts/reorganize_data.R")

# Pair down data frame to most recent month


# Inputs

  # Numeric Input - Monthly Net Income
numericInput("monthly_income",
             label = "Monthly Income",
             value = 4000)

  # Slider - % of Income spent on housing
  sliderInput("percent_income",
              label = "Percentage of Monthly Income for Rent",
              min = 0,
              max = 100,
              value = 25)

  # Select Input - # of rooms (apartment type)
  radioButtons("rental_type",
               label = "Rental Type",
               choices = list("All Homes",
                              "Studio",
                              "One Bedroom",
                              "Two Bedrooms",
                              "Three Bedrooms",
                              "Four Bedrooms",
                              "Five Bedrooms or More",
                              "Condo and Co-op",
                              "Duplex And Triplex",
                              "Single Family Residence",
                              "Multi-family Residence (5+)"),
               selected = "All Homes")
  
  # Panel display with description
  mainPanel(
    p(textOutput("budget")),
    h3("Cities Closest to Your Rent Budget"),
    p("The following fifteen cities are recommended
          based on your specified budget and rental type.
          These cities are recommended based on how closely median
          rental prices in that area match your budget."),
    tableOutput("city_list")
    )
  
# Outputs

  # Text Output - Rent budget and amount left to spend
  output$budget <- renderText({
    budget_text <- "Based on your specifications, your recommended rental budget is $"
    budget_amount <- input$monthly_income * input$percent_income / 100
    budget_left <- input$monthly_income - budget_amount
    budget_phrase <- paste0(budget_text, budget_amount,
                            "/month. You will have $", budget_left,
                            " left to spend after rent.")
  })
  
  # Recommended cities
  output$city_list <- renderTable({
    if (input$rental_type == "All Homes") {
      rental_df <- allHomes
    }
    if (input$rental_type == "Studio") {
      rental_df <- studio
    }
    if (input$rental_type == "One Bedroom") {
      rental_df <- one_b
    }
    if (input$rental_type == "Two Bedrooms") {
      rental_df <- two_b
    }
    if (input$rental_type == "Three Bedrooms") {
      rental_df <- three_b
    }
    if (input$rental_type == "Four Bedrooms") {
      rental_df <- four_b
    }
    if (input$rental_type == "Five Bedrooms or More") {
      rental_df <- five_b
    }
    if (input$rental_type == "Condo and Co-op") {
      rental_df <- condo_coop
    }
    if (input$rental_type == "Duplex And Triplex") {
      rental_df <- duplex
    }
    if (input$rental_type == "Single Family Residence") {
      rental_df <- sfr
    }
    if (input$rental_type == "Multi-family Residence (5+)") {
      rental_df <- mfr
    }
    
    budget_amount <- input$monthly_income * input$percent_income / 100
    
    rental_df <- rental_df %>%
      select(RegionName, X2019.01) %>%
      filter(RegionName != "United States") %>%
      mutate(rent_diff = abs(X2019.01 - budget_amount)) %>%
      arrange(rent_diff) %>%
      select("City" = RegionName,
             "Median Rental Price" = X2019.01)
    top_15 <- head(rental_df, 15)
  })