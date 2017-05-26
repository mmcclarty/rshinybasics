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
    

  output$toCol <- renderUI({
    df <- data()

    for(i in names(df)){
      #items<-as.character(df[[i]])
      #itemall[[i]] = items
      
      items<- as.character(df[[i]])
      # #This is if you just want the names of all the columns, i want the content
      # #items=names(df)
      # #names(items)=items
      
    }
    
    #Select the x and y variables for scatter plot
    updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                      choices = names(df), selected = names(df))
    updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                      choices = names(df), selected = names(df)[2])
    
    return(df)
  })
  
  output$contents <- renderTable({
    data()
  })
  
  output$MyPlot <- renderPlot({
    # Basic scatterplot
    x <- data()[, c(input$xcol, input$ycol)]
    plot(x)
    
  })
  
  output$joinedplot <- renderGvis({
     Bubble <- gvisBubbleChart(mtcars, idvar='hp',
                                 xvar=mtcars[1], yvar='mpg',
                                colorvar='cyl' sizevar="gear",
          )
      })
      
    })
    
    })
  
 
  })
