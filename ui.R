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
    helpText("")
    ),
  wellPanel(
      helpText(HTML("<b>VERSION CONTROL</b>")),
      HTML('Version 0.8.0'),
      HTML('<br>'),
      HTML('Deployed on June 3rd, 2014'),
      HTML('<br>'),
      HTML('<a href="https://github.com/hansthompson/dipnet_app" target="_blank">Code on GitHub</a>')
    ) 

  ),
  
  mainPanel(
    
    tabsetPanel(
      tabPanel("Introduction", includeMarkdown("docs/introduction.md")),
      tabPanel("2014 Real Time", 
               plotOutput("realtime"),
               plotOutput("tides"),
               plotOutput("testFishery"),
               plotOutput("testFisheryComments")
      ), 
      tabPanel("Prior Sonar Counts", 
               plotOutput("barchart"),
               plotOutput("linechart")

               
      ) 
    )
    
  )
))