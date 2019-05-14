#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(magrittr)
library(ggplot2)
library(lubridate)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # load data
    marathon_2019 <- read.delim2("data/marathon_results_2019_updated.txt", stringsAsFactors=FALSE)    
    marathon_2019$Official.Time <- hms(marathon_2019$Official.Time)
    
    marathon_2018 <- read.delim2("data/marathon_results_2018_updated.txt", stringsAsFactors=FALSE)    
    marathon_2018$Official.Time <- hms(marathon_2018$Official.Time)
    
    marathon_2017 <- read.delim2("data/marathon_results_2017_updated.txt", stringsAsFactors=FALSE)    
    marathon_2017$Official.Time <- hms(marathon_2017$Official.Time)
    
    marathon_2016 <- read.delim2("data/marathon_results_2016_updated.txt", stringsAsFactors=FALSE)    
    marathon_2016$Official.Time <- hms(marathon_2016$Official.Time)
    
    # generate bins based on input$bins from ui.R
    if (input$year == 2016)  x <- as.numeric(marathon_2016$Official.Time)/3600
    if (input$year == 2017)  x <- as.numeric(marathon_2017$Official.Time)/3600
    if (input$year == 2018)  x <- as.numeric(marathon_2018$Official.Time)/3600
    if (input$year == 2019)  x <- as.numeric(marathon_2019$Official.Time)/3600
    bins <- seq(min(x, na.rm = T), max(x, na.rm = T), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
