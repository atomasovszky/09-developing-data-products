library(shiny)

shinyUI(

    fluidPage(
        titlePanel("Predict horsepower from MPG"),
        sidebarPanel(
            sliderInput(
                "sliderMPG", "What is the MPG of the car", 10, 35, 20
            ),

            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),

            submitButton("Submit")
        ),

        mainPanel(
            plotOutput("plot1"),

            h3("Predicted horsepower from Model 1:"),
            textOutput("prediction1"),

            h3("Predicted horsepower from Model 2:"),
            textOutput("prediction2")
        )
    )

)