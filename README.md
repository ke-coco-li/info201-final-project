# info201-final-project
## Project Description
- What is the dataset we will be working with?

  The datasets our team will be working with come from [Zillow Research](https://www.zillow.com/research/data/). Specifically, we'll be analyzing Metro Median Rental Prices by Housing Type, Metro Median Household Income, and the Metro Rent Affordability datasets. There are a total of **13** datasets that can be joined together by region id and regionname. Zillow provided these datasets and updates them quarterly.  

- Who is our target audience? What does our audience want to learn from our data?

  The target audience for our rental housing visualizations and report would be *current and prospective renters*. We'd like to provide trends and analysis on where rental housing prices are most affordable, how they've changed over the years, and provide other additional information on the current rental housing landscape.

  Some of the questions our project will answer includes:

    + What are the trends of monthly rent in different states by housing types?
    + Based on your income and rent affordability limit, which cities can you afford to live in?
    + Which cities in the United States have the highest or the lowest average monthly rent in the past 10 years?
    + How does rent affordability change from the west to east coast? And is rent affordability issues a national concern or is it only isolated to a limited number of areas?

## Technical Description
- How will we be reading in your data?

  Our project will be presented as a Shiny app. We will be reading our data using static CSV files obtained from Zillow Research as we mentioned in the project description.

- What types of data-wrangling will we need to do to your data?

  We will need to perform join functions in R Studio to combine our datasets using unique identifiers to make it easier to analyze the data, as well as to make it more relevant for our target audience. Cleaning our dataset will be essential, and identifying Null values will also help us gain a better understanding of the completeness and viability of our datasets. We will also need to perform aggregate functions using base R and dpylr to help identify time-based trends and rolling averages from our data. Additionally, we will reshape our datasets in order to answer specific questions such as comparing the ratings to months.

  We will use statistical analysis to show the relationship between the rent, income, cities, and other characteristics in corresponding charts or maps in order to answer the questions listed above.

- What (major/new) libraries will be using in this project?

  + [Plotly](https://plot.ly/ggplot2/) for scatterplots, boxplots, histograms, area charts, etc...

  + [Leaflet for R](https://rstudio.github.io/leaflet/) for interactive maps

  + [Shiny](http://shiny.rstudio.com/tutorial/) for creating interactive web applications

  +[CSS](https://shiny.rstudio.com/articles/css.html) CSS for styling our Shiny application and giving it a more polished look

In addition to the libraries listed above, we will also be incorporating dplyr and stringr as needed. 

- What major challenges do we anticipate?

  We anticipate that the data wrangling portion will be most difficult. It may also be a challenge to figure out how to integrate interactive visualizations into our report, since we are still in the phase of learning how to apply Shiny and create powerful visualizations with it. Since this is our final project, we'll want to take risks and experiment with some of our charts and maps, so we expect steep learning curves for the charts where we experiment. Finally, since this is a larger project with multiple features and contributors, we'll expect challenges related to effective collaboration. Even with the challenges listed, we still expect to come out alright by focusing on effective communication and feedback with our team members.    
