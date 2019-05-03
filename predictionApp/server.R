library(shiny)
library(data.table)
library(ggplot2)
shinyServer(function(input, output) {

    mtcars <- as.data.table(mtcars)
    mtcars[, mpgsp := ifelse(mpg - 20 > 0, mpg - 20, 0)]
    model1 <- lm(hp ~ mpg, data = mtcars)
    model2 <- lm(hp ~ mpg + mpgsp, data = mtcars)

    model1pred <- reactive({
        predict(model1, newdata = data.table(mpg = input$sliderMPG))
    })

    model2pred <- reactive({
        predict(model2, newdata = data.table(
                mpg   = input$sliderMPG,
                mpgsp = ifelse(input$sliderMPG - 20 > 0, input$sliderMPG - 20, 0)
            )
        )
    })

    output$plot1 <- renderPlot({
        model1line <- predict(model1, data.table(mpg = 10:35))
        model2line <- predict(model2, newdata = data.table(
                mpg   = 10:35,
                mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
            )
        )
        mtcars_w_pred <- merge(
            mtcars,
            data.table(mpg = 10:35, hp_pred1 = model1line, hp_pred2 = model2line),
            "mpg",
            all = TRUE
        )
        mpginput <- input$sliderMPG
        p <- ggplot(mtcars_w_pred, aes(mpg, hp)) +
            geom_point(alpha = .5, size = 3) +
            theme_bw() +
            labs(x = "Miles per Gallon", y = "Horsepower") +
            geom_point(mapping = aes(x = input$sliderMPG, y = model1pred()), color = "blue", size = 5, alpha = .5) +
            geom_point(mapping = aes(x = input$sliderMPG, y = model2pred()), color = "red", size = 5, alpha = .5)
        if (input$showModel1 == TRUE) {
            p <- p + geom_line(mapping = aes(mpg, hp_pred1), colour = "blue", alpha = .5, size = 1)
        }
        if (input$showModel2 == TRUE) {
            p <- p + geom_line(mapping = aes(mpg, hp_pred2), colour = "red", alpha = .5, size = 1)
        }
        p + labs(x = "Miles per Gallon", y = "Horsepower")
    })

    output$prediction1 <- renderText({
        model1pred()
    })

    output$prediction2 <- renderText({
        model2pred()
    })
})
