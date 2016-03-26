#Load required packages
library(shiny)
data <- read.csv("output.csv")
cyl <- sort(unique(data$cylinders))
drive <- unique(data$drive)
fuelType <- unique(data$fuelType)
classes <- unique(data$VClass)

shinyUI(fluidPage(
    
    titlePanel("EPA Fuel Economy Database"),
  
    sidebarLayout(
        sidebarPanel(
            helpText("Make selections to narrow the field"),
      
            
            selectInput("fueltype", "Fuel Type of vehicle:", choices=as.character(fuelType), 
                    selected="Hybrid"
                ),
                  
            sliderInput("yearrange", 
                label = "Years of interest:",
                min = 1978, max = 2016, value = c(1978, 2016)
                ),
      
            sliderInput("mpgrange", 
                label = "MPG range:",
                min = 7, max = 90, value = c(7, 90)
                ),
      
            sliderInput("displrange", 
                label = "Displacement range:",
                min = .9, max = 9, step=.1, value = c(.9,9)
                ),
            
            selectInput("drive", "Select drive type", choices=as.character(drive),
                selected="FWD"
                ),
            
            checkboxGroupInput("cylnum", "Number of Cylinders:", choices=cyl, 
                selected=cyl
                ),
            
            checkboxGroupInput("class", "Choose vehicle class:", 
                choices=as.character(classes), selected=classes
                ),
            
            checkboxInput("makechoose", "Make"),
                        
            conditionalPanel(
                condition = "input.makechoose == true",
                checkboxGroupInput("makes", "Sort by popular makes:", 
                                   choices=tail(names(sort(summary(data$make))),40),
                                   selected=tail(names(sort(summary(data$make))),40)
                )
            )
        ),
    
    mainPanel(h3("Selections: "),
      textOutput("years.choice"),
      textOutput("mpg.choice"),
      textOutput("displ.choice"),
      textOutput("makes.choices"),
      dataTableOutput("Chart")
            )
        )
    )
)