server <- function(input, output) {

    mtcars <- mtcars %>%
        as.data.table() %>%
        .[, `:=`(
            vs   = as.factor(vs),
            am   = as.factor(am),
            cyl  = as.factor(cyl),
            gear = as.factor(gear),
            carb = as.factor(carb)
        )]

    continuous_variables <- c("mpg", "disp", "hp", "drat", "wt", "qsec")
    categorical_variables <- setdiff(names(mtcars), continuous_variables)

    output$distribution_plot_cat <- renderPlot({
        mtcars %>%
            .[, .SD, .SDcols = categorical_variables] %>%
            setnames(names(.), getPrettyNames(categorical_variables)) %>%
            melt(measure.vars = getPrettyNames(categorical_variables)) %>%
            ggplot(aes(x = value)) +
                geom_bar(alpha = .75) +
                coord_flip() +
                geom_label(stat = "count", aes(label = ..count..), size = 2, family = "Roboto Slab") +
                facet_wrap(~variable, scales = "free") +
                labs(x = "", y = "") +
                theme_bw(base_family = "Roboto Slab")
    })

    output$distribution_plot_con <- renderPlot({
        mtcars %>%
            .[, .SD, .SDcols = continuous_variables] %>%
            setnames(names(.), getPrettyNames(continuous_variables)) %>%
            melt(measure.vars = getPrettyNames(continuous_variables)) %>%
            ggplot(aes(x = value)) +
                geom_histogram(bins = 10, alpha = .75) +
                facet_wrap(~variable, scales = "free") +
                labs(x = "", y = "") +
                theme_bw(base_family = "Roboto Slab")
    })

    basic_linear_relationship_plot <- reactive({
        mtcars[, lapply(.SD, as.numeric)] %>%
            ggplot(aes_string(x = input$predictor, y = "mpg")) +
            geom_point(size = 2, alpha = .5) +
            labs(x = input$predictor, y = "mpg")
    })

    output$linear_relationship_plot <- renderPlot({
        basic_linear_relationship_plot() +
            stat_smooth(method = "lm", se = FALSE, formula = y ~ poly(x, as.integer(input$degree)))
    })

    linear_model <- reactive({
        cols <- c("mpg", unlist(input$features))
        mtcars[, .SD, .SDcols = cols] %>%
            lm(data = ., formula = mpg ~ .)
    })

    output$lm_summary <- renderTable({
        lm_sum <- linear_model() %>% summary %>% .[["coefficients"]]
        data.table(` ` = rownames(lm_sum), lm_sum) %>% as.data.frame
    })

    output$diag_plot_1 <- renderPlot({plot(linear_model(), which = 1)})
    output$diag_plot_2 <- renderPlot({plot(linear_model(), which = 2)})
    output$diag_plot_3 <- renderPlot({plot(linear_model(), which = 3)})
    output$diag_plot_4 <- renderPlot({plot(linear_model(), which = 4)})
    output$diag_plot_5 <- renderPlot({plot(linear_model(), which = 5)})
    output$diag_plot_6 <- renderPlot({plot(linear_model(), which = 6)})
}