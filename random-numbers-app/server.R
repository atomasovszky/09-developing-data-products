library(shiny)
library(ggplot2)
library(data.table)
library(magrittr)

shinyServer(function(input, output) {
   
    output$scatterplot <- renderPlot({
        
        data.table(
            x = runif(
                n   = input$num_random_nums, 
                min = input$xlims[1], 
                max = input$xlims[2]
            ),
            y = runif(
                n   = input$num_random_nums, 
                min = input$ylims[1], 
                max = input$ylims[2]
            )
        ) %>% 
            ggplot(aes(x, y)) + 
                geom_point(alpha = .5, size =  2) +
                labs(
                    title = ifelse(input$showTitle, "Random points", "") ,
                    x     = ifelse(input$showX, "X axis", ""),
                    y     = ifelse(input$showY, "Y axis", "")
                ) +
                theme_bw()
    
    })
  
})
