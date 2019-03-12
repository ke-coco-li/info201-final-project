#Final Project: ui.R
library(dplyr)
library(shiny)
library(leaflet)
library(shinythemes)

# Creating UI
ui <- shinyUI(navbarPage(
  "Rent Statistics in the United States",
  fluid = TRUE, theme = shinytheme("superhero"),
  
  # tab panel #1:
  tabPanel(
    "Summary",
    titlePanel("Summary"),
    HTML(readLines("www/summary.html")),
    includeCSS("www/css/custom.css")
  ),
  
  # tab panel #2: rent affordability map
  tabPanel(
    "Rent Affordability Map",
    titlePanel("2018 Rent Affordability Statistics"),
    
    # Creating a sidbar layout
    sidebarLayout(
      
      # side panel for controls
      sidebarPanel(
        
        # 'radioButtons' to change the # of cities shown
        radioButtons(
          "city_size",
          label = "City Size Rank",
          choices = list(
            "Top 10" = 10, "Top 50" = 50,
            "Top 100" = 100, "Top 300" = 600
          ),
          selected = 50
        ),
        
        # 'sliderInput' to change the affordability % threshold - NEED TO EDIT
        sliderInput(
          "percentage",
          label = "Affordability Percentage",
          min = .1,
          max = .5,
          value = .30
        )),
      
      # Main panel for displaying rent affordability map
      mainPanel(
        leafletOutput("affordability_map")
      )
    )
  ),
  
  # tab panel #3:
  tabPanel(
    "Example #2",
    titlePanel("Example Title")
  ),
  
  # tab panel #4:
  tabPanel(
    "Rent Trend Plot",
    titlePanel("Median Monthly Rent from 2010 to 2019"),
    sidebarLayout(
      sidebarPanel(
        textInput(
          "chosen_state", 
          label = "Type in A State of Your Interest", 
          value = "United States", 
          placeholder = "Enter the abbreviation (eg. NY)"
        ),
        uiOutput("select_city"),
        checkboxGroupInput("home_types",
                           "Please select home types:",
                           c("All Homes","Studio","One Bedroom","Two Bedrooms","Three Bedrooms",
                             "Four Bedrooms","Five Bedrooms or More","Condo And Co-op",
                             "Duplex And Triplex","Single Family Residence","Multi-family Residence (5+)"),
                           selected = "All Homes")
      ),
      mainPanel(
        plotOutput("plot")
      )
    )
  ),
  # tab panel #5:
  tabPanel(
    "Example #4",
    titlePanel("Example Title")
  )
)
)

