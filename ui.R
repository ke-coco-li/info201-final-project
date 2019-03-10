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
    titlePanel("Example Title"),
    sidebarLayout(
      sidebarPanel(
        # First widget of a select box.
        textInput(
          "chosen_state", 
          label = "Type in A State of Your Interest (The default graph is for the United States.)", 
          value = "United States", 
          placeholder = "Please enter the two-letter abbreviation of a state or DC..."
        ),
        # First widget of a select box.
        uiOutput("select_city"),
        # Second widget of a checkbox.
        checkboxInput(
          "all_homes", 
          label = strong("All Homes"), 
          value = TRUE
        ),
        checkboxInput(
          "studio", 
          label = strong("Studio"), 
          value = FALSE
        ),
        checkboxInput(
          "one_bed", 
          label = strong("One Bedroom"), 
          value = FALSE
        ),
        checkboxInput(
          "two_bed", 
          label = strong("Two Bedrooms"), 
          value = FALSE
        ),
        checkboxInput(
          "three_bed", 
          label = strong("Three Bedrooms"), 
          value = FALSE
        ),
        checkboxInput(
          "four_bed", 
          label = strong("Four Bedrooms"), 
          value = FALSE
        ),
        checkboxInput(
          "five_bed", 
          label = strong("Five Bedrooms or More"), 
          value = FALSE
        ),
        checkboxInput(
          "condo_coop", 
          label = strong("Condo And Co-op"), 
          value = FALSE
        ),
        checkboxInput(
          "duplex_triplex", 
          label = strong("Duplex And Triplex"), 
          value = FALSE
        ),
        checkboxInput(
          "sfr", 
          label = strong("Single Family Residence"), 
          value = FALSE
        ),
        checkboxInput(
          "mfr", 
          label = strong("Multi-family Residence (5+)"), 
          value = FALSE
        ),
        sliderInput(
          "year_range", 
          label = "Choose the range of specific years", 
          min = 0,
          max = 50, 
          value = c(0, 50)
        )
      ),
      mainPanel(
        plotlyOutput("plot")
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

