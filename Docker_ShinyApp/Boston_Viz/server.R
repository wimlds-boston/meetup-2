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
    
    # select dataset based on input$year
    if (input$year == 2016)  df <- marathon_2016
    if (input$year == 2017)  df <- marathon_2017
    if (input$year == 2018)  df <- marathon_2018
    if (input$year == 2019)  df <- marathon_2019
    
    # subset to input$gender
    if (input$gender != "All") {
      if (input$gender == "Female") df <- df[df$M.F == "F",]
      if (input$gender == "Male") df <- df[df$M.F == "M",]
    }
    
    # subset to input$age
    df <- df[((df$Age >= input$age[1]) & (df$Age <= input$age[2])),]
    
    # draw the histogram
    ggplot(df, aes(as.numeric(hms(df$Official.Time))/3600)) + 
      geom_histogram(alpha = 0.5) + 
      theme_bw() +
      xlab("Official finish time (hours)") +
      ylab("Number of finishers") +
      xlim(c(2,8))
    
  })
  
})
