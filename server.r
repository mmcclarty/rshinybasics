library(shiny)
library(ggplot2)
library(sp)
library(htmltools)
library(googleVis)


shinyServer(function(input, output, session) {
  
  #Allow user to browse locally for data
  data <- reactive({ 
    req(input$file1) 
    
    inFile <- input$file1 
    
    df <- read.csv(inFile$datapath, header = input$header, sep = input$sep,
                   quote = input$quote)
  
      
    #Select the variables for plot
    updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                        choices = names(df), selected = names(df))
    updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                        choices = names(df), selected = names(df)[2])
    updateSelectInput(session, inputId = 'id', label = 'ID Variable',
                      choices = names(df), selected = names(df)[3])
    updateSelectInput(session, inputId = 'colour', label = 'Colour Variable',
                      choices = names(df), selected = names(df)[4])
      
    return(df)
    })
    
    output$contents <- renderTable({
      data()
    })
    
    output$joinedplot <- renderGvis({
      plotStyle(data(), input$choosePlot)
    })
    
    plotStyle <- function(data, type){
      switch(type,
             Scatter = gvisScatterChart(data(),
                                        options=list(
                                          legend="none",
                                          linewidth=0, pointSize=2,
                                          title=input$title)),
             Bar = gvisBarChart(data(), xvar = input$xcol, yvar = input$ycol, options=list(
               title=input$title)),
             Bubble = gvisBubbleChart(data(), idvar=input$id, 
                                                xvar=input$xcol, yvar=input$ycol,
                                                colorvar=input$colour, #sizevar="Profit",
                                                options=list(
                                                  title=input$title,
                                                  hAxis='{minValue:75, maxValue:125}'))
             )
    }
    
  })
  

