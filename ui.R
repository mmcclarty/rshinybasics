library(shiny)
library(ggplot2)
library(leaflet)
library(sp)
library(bootstrap)
library(shinythemes)
library(sqldf)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "united",
  tabsetPanel(
    tabPanel("Upload First Data File",
             sidebarLayout(
               sidebarPanel(
               #Choose and upload file from local machine
                 fileInput('file1', 'Choose CSV File',
                           accept=c('text/csv', 
                                    'text/comma-separated-values,text/plain', 
                                    '.csv')),
               ),
               mainPanel(
                 h2('Selected Data'),
                 p(),
                 tableOutput('contents')
               )
             )
    ),
    tabPanel("Upload Second Data File",
             pageWithSidebar(
               headerPanel("Choose Second File"),
               sidebarPanel(
               ),
               mainPanel(
                 
               )
             )
    ),
    tabPanel("Join Data",
             pageWithSidebar(
               headerPanel("Hi"),
               sidebarPanel(
                 h3("Empty")
               ),
               mainPanel(
                
               )
             )
    ),
    tabPanel("Plot Data",
             pageWithSidebar(
               headerPanel('My First Plot'),
               sidebarPanel(
                 
                 # "Empty inputs" - they will be updated after the data is uploaded
                 selectInput('xcol', 'X Variable', ""),
                 selectInput('ycol', 'Y Variable', "", selected = "")
                 
               ),
               mainPanel(
                 plotOutput('MyPlot')
                 htmlOutput("joinedplot")
               )
             )
    )
  
        )

  )
)
