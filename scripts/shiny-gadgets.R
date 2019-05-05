library(shiny)
library(miniUI)

myFirstGadget <- function() {
    ui <- miniPage(
        gadgetTitleBar("My first gadget")
    )

    server <- function(input, output, session) {
        observeEvent(input$done, {
            stopApp()
        })
    }
    
    runGadget(ui, server)
}