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
        leafletOutput("affordability_map"), width = 7
      )
    )

  ),
  
  # tab panel #3:
  tabPanel(
    "City Finder Tool",
    titlePanel("Find Cities That Match Your Budget"),
    sidebarLayout(
      sidebarPanel(
        numericInput("monthly_income",
                     label = "Monthly Income",
                     value = 4000),
        sliderInput("percent_income",
                    label = "Percentage of Monthly Income for Rent",
                    min = 0,
                    max = 100,
                    value = 25),
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
      ),
      mainPanel(
        p(textOutput("budget")),
        h3("Cities Closest to Your Rent Budget"),
        p("The following fifteen cities are recommended
          based on your specified budget and rental type.
          These cities are recommended based on how closely median
          rental prices in that area match your budget."),
        tableOutput("city_list")
      )
    )
  ),
  
  # tab panel #4:
  tabPanel(
    "Rent Trend Plot",
    titlePanel("Median Monthly Rent 2010-2019"),
    p("As shown in the default plot, from 2010 to 2019, the median monthly rate within 
      the scope of United States was in an increasing trend. It was quite stable during 
      last 4 years and had a noticable drop between 2011 and 2014. For most of the states in the 
      United States, the monthly rent trending was linearly increasing for the last 9 years, 
      and may be continue rising in next few years."),
    sidebarLayout(
      sidebarPanel(
        textInput(
          "chosen_state", 
          label = "Type A State of Your Interest", 
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
        plotOutput("trend_plot")
      )
    )
  ),
  # tab panel #5:
  tabPanel(
    "Rent vs. Sales",
    titlePanel("Side by Side Comparison of Rent and Sales"),
    sidebarLayout(
      sidebarPanel(
        textInput("state",
                  label = "Type In The State of Interest",
                  value = "Washington",
                  placeholder = "Enter full State name (eg. Texas)")
      ),
      mainPanel(
        plotOutput("rentplot"),
        plotOutput("salesplot"),
        p("*Data for some years was unavailable from the source which resulted in the 0's
          and low outliers shown in the data."
        )
      )
    )
  )
)
)