library(shiny)
library(ggplot2)
library(data.table)
library(magrittr)

shinyUI(fluidPage(
  
    titlePanel("Plot random numbers"),
  
    sidebarLayout(

        sidebarPanel(
            
            numericInput(
                inputId = "num_random_nums",
                label   = "How many random numbers should be plotted?",
                value   = 1000
            ),
            
            sliderInput(
                inputId = "xlims",
                label   = "Pick minimum and maximum X values",
                min = -100,
                max = 100,
                value = c(-50, 50)
                ),
                
            sliderInput(
                inputId = "ylims",
                label   = "Pick minimum and maximum Y values",
                min = -100,
                max = 100,
                value = c(-50, 50)
            ),
                
            checkboxInput(
                inputId = "showX",
                label   = "Show/Hide X axis label",
                value   = TRUE
            ),
                
            checkboxInput(
                inputId = "showY",
                label   = "Show/Hide Y axis label",
                value   = TRUE
            ),
                
            checkboxInput(
                inputId = "showTitle",
                label   = "Show/Hide title",
                value   = FALSE
            )
        
        ),
        
        
        mainPanel(
            h1("Graph of random points"),
            plotOutput("scatterplot")
        )
  
    )
  
))
