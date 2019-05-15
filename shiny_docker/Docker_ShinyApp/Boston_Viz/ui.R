#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Boston Marathon Results"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Year:", 
                  choices=c(2016:2019), selected = 2019),
      radioButtons("gender", "Gender",
                   choices = c("All", "Female", "Male"),
                   selected = "All"),
      sliderInput("age",
                  "Age:",
                  min = 18,
                  max = 85,
                  value = c(18, 60)),
      textInput("name", "Runner name")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        id = "results",
        tabPanel("Times Histogram",
                 plotOutput("distPlot")
        ),
        tabPanel("Runner's data",
                 dataTableOutput("runnerData")
        )
      )
    )
  )
))
