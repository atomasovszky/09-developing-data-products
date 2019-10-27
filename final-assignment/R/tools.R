visualize2dRegression <- function(dt, response, regressor, degree = 1) {
    fit <- lm(get(response) ~ poly(get(regressor), degree), dt)
    data <- data.table(
        reponse_label   = response,
        regressor_label = regressor,
        response        = dt[[response]],
        regressor       = dt[[regressor]],
        fit             = predict(fit)
    )
    ggplot(data, aes(regressor, fit)) +
        geom_line(col = "blue", alpha = .75) +
        geom_point(aes(regressor, response), size = 3, alpha = .5) +
        labs(x = regressor, y = response) +
        theme_bw(base_family = "Roboto Slab")
}

ggpairsCorrelation <- function(data, mapping, font_size = 12) {
    p <- ggplot(data = data, mapping = mapping)
    x <- p$data[[as.character(rlang::quo_get_expr(p$mapping$x))]]
    y <- p$data[[as.character(rlang::quo_get_expr(p$mapping$y))]]
    corr <- cor(x, y, use = "pairwise.complete.obs") %>%
        sprintf(fmt = "%.3f", x = .)

    p +
        theme_bw(base_family = "Roboto Slab") +
        labs(x = "", y = "") +
        theme(axis.text = element_blank()) +
        geom_label(
            size          = font_size,
            family        = "Roboto Slab",,
            label.size    = NA,
            fill          = NA,
            mapping       = aes(
                x     = mean(range(x)/2),
                y     = mean(range(y)/2),
                label = corr
            )
        )
}

ggpairsSmooth <- function(data, mapping) {
    p <- ggplot(data = data, mapping = mapping) +
        geom_point(size = .5, alpha = .5) +
        geom_smooth(se = FALSE, lwd = .5, method = "lm") +
        labs(x = "", y = "") +
        theme_bw(base_family = "Roboto Slab") +
        theme(axis.text = element_blank())
    return(p)
}

ggpairsDensity <- function(data, mapping) {
    p <- ggplot(data = data, mapping = mapping) +
        geom_density(alpha = .5, fill = "black", colour = NA) +
        labs(x = "", y = "") +
        theme_bw(base_family = "Roboto Slab") +
        theme(axis.text = element_blank())
    p
}

getPrettyNames <- function(original_names) {
    colnames <- data.table(pretty = c(
        "Miles/gallon", "Number of cylinders", "Displacement (cu.in.)",
        "Gross horsepower", "Rear axle ratio", "Weight (1000 lbs)",
        "1/4 mile time", "Engine (0 = V-shaped, 1 = straight)",
        "Transmission (0 = automatic, 1 = manual)", "Number of forward gears",
        "Number of carburetors"
    ), orig = names(mtcars)) %>%
        .[, pretty := gsub("\\(", "\n(", pretty)] %>%
        .[]

    return(colnames[orig %in% original_names, pretty])
}
