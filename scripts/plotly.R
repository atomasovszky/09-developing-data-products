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

# line plots
data(airmiles)
plot_ly(x = time(airmiles), y = airmiles, type = "scatter", mode = "line")

# multiline
library(tidyr)
library(dplyr)
data("EuStockMarkets")

stocks <- as.data.frame(EuStockMarkets) %>%
  gather(index, price) %>%
  mutate(time = rep(time(EuStockMarkets), 4))

plot_ly(stocks, x = ~time, y = ~price, color = ~index, type = "scatter", mode = "lines")

# simpler graphs
plot_ly(x = ~precip, type = "histogram")
plot_ly(iris, y = ~Petal.Length, color = ~Species, type = "box")

terrain1 <- matrix(rnorm(100*100), nrow = 100, ncol = 100)
plot_ly(z = terrain1, type = "heatmap")

terrain2 <- matrix(sort(rnorm(100*100)), nrow = 100, ncol = 100)
plot_ly(z = terrain2, type = "surface")