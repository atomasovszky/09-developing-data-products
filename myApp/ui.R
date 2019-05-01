library(shiny)

shinyUI(
    fluidPage(
        
        titlePanel("Data Science FTW"),

        sidebarLayout(
            sidebarPanel(
                h3("Sidebar text")
            ),
            mainPanel(
                h3("Main panel text")
            )
        )
       
    )
)
