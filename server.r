library(ggplot2)
library(plyr)
library(shiny)
library(lubridate)
library(stringr)
library(gridExtra)

shinyServer(function(input, output) {  
  
  #Set base directory to load data from 
  myDirectory <- "C:\\Users\\Hans T\\Documents\\GitHub\\dipnet_app\\data"
  ########LOAD SONAR#######
  load(paste(myDirectory, "kenai_data.rda", sep = "/"))
  ########GET REALTIME#####
  load(paste(myDirectory, "rt_dat.rda" , sep = "/"))
  ########TEST FISH########
  load(paste(myDirectory, "testFish.rda", sep = "/"))

  ########PROCESSING#######
  tides_reactive <- reactive({  
    days_in_the_future <- 1
    start_time <- now() - hours(10)
    end_time <- now() + days(days_in_the_future)
    return(tide_df[tide_df$times > start_time & tide_df$times < end_time,])
    #tides_reactive <- tide_df[tide_df$times > start_time & tide_df$times < end_time,]
  })
  
  sonar_reactive <- reactive({
    sonar_df$year <- factor(sonar_df$year)
    start_year <- as.numeric(input$start_year)
    end_year <- as.numeric(input$end_year)
    start_date <-  ymd(paste("2014",input$start_date, sep = "-"))
    end_date <- ymd(paste("2014", input$end_date, sep = "-"))
  
    sonar_df <- sonar_df[start_year <= as.numeric(levels(sonar_df$year))[sonar_df$year] &
                         end_year   >= as.numeric(levels(sonar_df$year))[sonar_df$year] &
                         start_date <= sonar_df$date &
                         end_date   >= sonar_df$date,]      
  return(sonar_df)
  #sonar_reactive <- sonar_df
  })
  
  realtime_reactive <- reactive({
    return(rt_dat2)
    #realtime_reactive <- rt_dat
  })
  ########################  

  #######PLOTING#########
  prior_linechart <- reactive({
    p <- ggplot(data = sonar_reactive(), aes(x = date, y = n, group = year, color = year)) + 
         geom_line()
    return(p)     
  })
  
  prior_barchart <- reactive({
    p <- ggplot(data = sonar_reactive(), aes(x = date, y = n, group = year, color = year, fill = year)) + 
         geom_bar(stat = "identity")
    return(p)    
  })
  
  realtime_chart <- reactive({
    ylimit <- max(realtime_reactive()$cfue_estimates)
    p <- ggplot(data = realtime_reactive(), aes(x = Date, y = cfue_estimates)) +   
      ylim(c(0, ylimit) * 1.1) +
      #xlim(c(real_tim$date[1], future)) 
      geom_line(aes(color = "red"), size = 3) +   
      #stat_smooth(  method = "lm", 
      #              formula = y ~ poly(x, 4), 
      #              level = 0.95,
      #              fullrange = FALSE,
      #              se = TRUE,
      #              aes(colour = "black")) +
      theme(legend.position="none") +
      ggtitle("Predicted Catch Per Effort") +
      ylab("Predicted Sockeye Catch Per Day") 
    return(p)
  })
  
  tide_chart <- reactive({
    p <- ggplot(data = tides_reactive(), aes(x = times, y = height)) +
      geom_smooth(method = "loess", se = FALSE) + ggtitle("Tidal Cycle") +
      ylab("River Depth in Feet")
    return(p)
  })

  testFishReactive <- reactive({
    p <- ggplot(data = testFish, aes(x = Date, y = StationCount, color = allIDs, fill = allIDs)) +
           geom_bar(stat = "identity") +
           ggtitle("Total Test Fish Caught in Cook Inlet") +
           ylab("Total Fish") +
           annotate("text",
                    x=unique(testFish$Date[testFish$Comment != ""]),
                    y=1,
                    label="*", size = 8) + 
           theme(legend.title=element_blank())
  
    return(p) 
  })

    #########################

  ######Publishing#########

  ###TABSET: REAL TIME#####
  output$realtime <- renderPlot({
    print(realtime_chart())
  })

  output$tides <- renderPlot({
    print(tide_chart())
  })

  output$testFishery <- renderPlot({
    print(testFishReactive())
  })

  output$testFisheryComments <- renderPlot({
  	##WEAKLY CODED RIGHT HERE FOLKS
    grid.table(d = unique(testFish[testFish$Comment != "", c(2, 9)]),
               show.rownames = FALSE)
  })
  
  ###TABSET: PRIOR DATA####
  output$linechart <- renderPlot({
    print(prior_linechart())
  })

  output$barchart <- renderPlot({
    p <- prior_barchart()
    print(p)
  })

})
  ##TABSET: ABOUT