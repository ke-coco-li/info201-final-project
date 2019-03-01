# info201-final-project
## Project Description
- What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.

  + The datasets our team will be working with come from [Zillow Research](https://www.zillow.com/research/data/). Specifically, we'll be analyzing Metro Median Rental Prices by Housing Type, Metro Median Household Income, and the Metro Rent Affordability datasets. There are a total of **13** datasets that can be joined together by region id and regionname. Zillow provided these datasets and updates them quarterly.  

- Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.
-What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.

  + The target audience for our rental housing visualizations and report would be *current and prospective renters*. We'd like to provide trends and analysis on where rental housing prices are most affordable, how they've changed over the years, and provide other additional information on the current rental housing landscape. Some of the questions our project will answer includes:

  + What are the trends of monthly rent in different states by housing types?
  + Based on your income and rent affordability limit, which cities can you afford to live in?
  +
  +
  
## Technical Description
- How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?

  + We will be reading it as static CSV files.

- What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?


- What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)

  + Possible libraries we may be using are:
     [Plotly](https://plot.ly/ggplot2/) for scatterplots, boxplots, histograms, area charts, etc...
     
     [Leaflet for R](https://rstudio.github.io/leaflet/) for interactive maps

- What major challenges do you anticipate?

  + We anticipate that the data wrangling portion will be most difficult. It may also be a challenge to figure out how to integrate interactive visualizations into our report. 
