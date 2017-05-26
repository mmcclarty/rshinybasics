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
                    tabPanel("Upload Data",
                             sidebarLayout(
                               sidebarPanel(
                                 fileInput('file1', 'Choose CSV File',
                                           accept=c('text/csv', 
                                                    'text/comma-separated-values,text/plain', 
                                                    '.csv')),
                                 
                                 # added interface for uploading data from
                                 # http://shiny.rstudio.com/gallery/file-upload.html
                                 tags$br(),
                                 checkboxInput('header', 'Header', TRUE),
                                 radioButtons('sep', 'Separator',
                                              c(Comma=',',
                                                Semicolon=';',
                                                Tab='\t'),
                                              ','),
                                 radioButtons('quote', 'Quote',
                                              c(None='',
                                                'Double Quote'='"',
                                                'Single Quote'="'"),
                                              '"')
                               ),
                               mainPanel(
                                 h2('Selected Data'),
                                 p(),
                                 tableOutput('contents')
                               )
                             )
                    ),
                    tabPanel("Plot Data",
                             pageWithSidebar(
                               headerPanel('Plot'),
                               sidebarPanel(
                                 radioButtons("choosePlot", "Choose style",
                                              list("Scatter","Bar","Bubble")),
                                 # "Empty inputs" - they will be updated after the data is uploaded
                                 selectInput('xcol', 'X Variable', ""),
                                 selectInput('ycol', 'Y Variable', "", selected = ""),
                                 selectInput('id', 'ID Variable', "", selected = ""),
                                 selectInput('colour','Colour Variable',"",selected=""),
                                 textInput("title", "Plot Title", "Data Plot")
                               ),
                               mainPanel(
                                 htmlOutput("joinedplot")
                               )
                             )
                    )
                    
                  )
                  
)
)
