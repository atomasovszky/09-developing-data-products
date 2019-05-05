library(plotly)

# simple scatterplot
plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", mode = "markers")

# scatterplot with colors
mtcars$cyl <- as.factor(mtcars$cyl)
plot_ly(
    mtcars,
    x = ~wt,
    y = ~mpg,
    color = ~cyl,
    size = ~hp,
    type = "scatter",
    mode = "markers"
)

# 3d scatterplot
set.seed(2016-07-21)
temp <- rnorm(100, mean = 30, sd = 5)
pressue <- rnorm(100)
dtime <- 1:100
plot_ly(x = ~temp, y = ~pressue, z = ~dtime,
        type = "scatter3d", color = ~temp)