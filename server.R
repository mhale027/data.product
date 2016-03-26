library(shiny)
library(dplyr)
data <- read.csv("output.csv")


shinyServer(
    function(input, output) {
  
        output$years.choice <- renderText({
            paste0("Year range from  ",
            input$yearrange[1], " to ", input$yearrange[2])
        })    
        
        output$mpg.choice <- renderText({
            paste0("MPG range from ",
                  input$mpgrange[1], " to ", input$mpgrange[2])
        })    
            
        output$displ.choice <- renderText({
            paste0("Displacement range from ",
                   input$displrange[1], " to ", input$displrange[2])
        })  
        
        output$makes.choices <- renderText({
            paste0("Makes: ", input$makes)
        })
        
        data.table  <- reactive({
            data <- filter(data, combmpg >= input$mpgrange[1] & combmpg <= input$mpgrange[2])
            data <- filter(data, year >= input$yearrange[1] & year <= input$yearrange[2])
            data <- filter(data, displ >= input$displrange[1] & displ <= input$displrange[2])
            data <- filter(data, make %in% input$makes)
            data <- filter(data, cylinders %in% input$cylnum)
            data <- filter(data, drive == input$drive)
            data <- filter(data, VClass %in% input$class)
            data <- filter(data, fuelType == input$fueltype)
            return(data)
        })
        
            
        output$Chart <-renderDataTable({
                data.table()
        })        
    }
)