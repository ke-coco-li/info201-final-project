#Final Project: ui.R
library(dplyr)
library(shiny)
library(shinythemes)

#Creating UI
# Creating ui
shinyUI(navbarPage(
  "Rent Statistics in the United States",
  fluid = TRUE, theme = shinytheme("superhero"),
  
  # tab panel #1:
  tabPanel(
    "Example #1",
    titlePanel("Example Title")
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
    "Example #3",
    titlePanel("Example Title")
    ),
# tab panel #5:
tabPanel(
  "Example #4",
  titlePanel("Example Title")
)

)
)

