library(shiny)
library(ggplot2)
# Define UI for application that plots random distributions 
shinyUI(fluidPage(
  
  # Application title
  headerPanel("Dipnet_App! - IN BETA"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
  
  wellPanel(
    helpText("Hi. Play around with the inputs to subset the historical data or look at the predictions."),
    textInput("start_year", "Start Year:", "2007"),
    textInput("end_year", "End Year:", "2012"),
    textInput("start_date", "Start Date:", "06-30"),
    textInput("end_date", "End Date:", "08-05")
  ),
  wellPanel(   
    img(src = "codeforanc.png"),
    helpText("test")
    )
  ),
  
  
  mainPanel(
    
    tabsetPanel(
      tabPanel("Real Time", 
               plotOutput("realtime"),
               plotOutput("tides")
      ), 
      tabPanel("Prior Sonar Counts", 
               plotOutput("linechart"),
               plotOutput("barchart")
               
      ) 
    )
    
  )
))