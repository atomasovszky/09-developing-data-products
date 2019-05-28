library(shiny)
library(miniUI)
library(ggplot2)
library(data.table)

multiplierGadget <- function(numbers1, numbers2) {
    
    ui <- miniPage(
        gadgetTitleBar("Multiply two numbers"),
        miniContentPanel(
            selectInput("num1", "First number", choices = numbers1),
            selectInput("num2", "Second number", choices = numbers2)
        )
    )

    server <- function(input, output, session) {
        observeEvent(input$done, {
            num1 <- as.numeric(input$num1)
            num2 <- as.numeric(input$num2)
            stopApp(num1 * num2)
        })
    }
    
    runGadget(ui, server)
}

multiplierGadget <- function() {
    
    ui <- miniPage(
        gadgetTitleBar("Multiply two numbers"),
        miniContentPanel(
            fillCol(
                fillRow(
                    sliderInput("mean", label = "Mean", min = -50, max = 50, value = 0, step = 5),
                    sliderInput("sd", label = "SD", min = 1, max = 100, value = 1, step = 1)
                ),
                plotOutput("plot")
            )
        )
        
    )
    
    server <- function(input, output, session) {
        output$plot <- renderPlot({
            ggplot(data.table(x = rnorm(10000, input$mean, input$sd)), aes(x)) +
                geom_histogram(bins = 50, alpha = .5) +
                coord_cartesian(xlim = c(-200, 200))
        })
        observeEvent(input$done, {
            stopApp()
        })
    }
    
    runGadget(ui, server)
}
