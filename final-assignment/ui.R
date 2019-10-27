ui <- navbarPage(
    "Analysing the factors behind average consumption using the mtcars dataset",
    fluid = TRUE,

    tabPanel("Description",
        fluidRow(
            column(12,
                br(),
                h4("Introduction"),
                "The aim of this app is to create a linear regression model with what we'd like to identify what are the most important factors behind the average consumption of cars.",
                br(),

                h4("Instructions"),
                "1. In the 'Distribution of the variables' tab you can have a look at the distribution of the variables in the mtcars dataset", br(),
                "2. In the next tab you can experiment look at the linear relationship between consumption and each of the predictors. Here you can also experiment with the usage of polynomials in the linear model.", br(),
                "3. In the third tab you can put together your final linear regression model and adjust it according to the diagnostics shown.", br()
            )
        )
    ),
    tabPanel(
        "Distribution of the variables",
        fluidRow(
            column(6, h4("Distribution of continuous variables"), plotOutput("distribution_plot_con")),
            column(6, h4("Distribution of categorical variables"), plotOutput("distribution_plot_cat"))
        )
    ),
    tabPanel(
        "Linear relationship of mpg and and the other variables",
        fluidRow(
            column(6, selectInput("predictor", "Predictor", names(mtcars) %>% setdiff("mpg"))),
            column(6, selectInput("degree", "Degree of polynomial", 1:3, 1)),
            plotOutput("linear_relationship_plot")
        )
    ),
    tabPanel(
        "Final linear regression model",
        fluidRow(
            column(12,
                selectizeInput(
                    "features",
                    "Features",
                    choices = list(
                        cyl = "cyl",
                        disp = "disp",
                        hp = "hp",
                        drat = "drat",
                        wt = "wt",
                        qsec = "qsec",
                        vs = "vs",
                        am = "am",
                        gear = "gear",
                        carb = "carb"
                    ),
                    multiple = TRUE
                )
            )
        ),
        fluidRow(column(6, tableOutput("lm_summary"))),
        fluidRow(
            column(6,
                plotOutput("diag_plot_1"),
                plotOutput("diag_plot_3"),
                plotOutput("diag_plot_5")
            ),
            column(6,
                plotOutput("diag_plot_2"),
                plotOutput("diag_plot_4"),
                plotOutput("diag_plot_6")
            )
        )
    )
)


# ui <- navbarPage(

#     tabPanel("Description",
#         fluidRow(
#             column(12,
#                 br(),
#                 h4("Introduction"),
#                 "The aim of this app is to create a linear regression model with what we'd like to identify what are the most important factors behind the average consumption of cars.",
#                 br(),

#                 h4("Instructions"),
#                 "1. In the 'Distribution of the variables' tab you can have a look at the distribution of the variables in the mtcars dataset", br(),
#                 "2. In the next tab you can experiment look at the linear relationship between consumption and each of the predictors. Here you can also experiment with the usage of polynomials in the linear model.", br(),
#                 "3. In the third tab you can put together your final linear regression model and adjust it according to the diagnostics shown.", br()
#             )
#         )
#     ),
#     tabPanel(

#     ),
#     tabPanel(
#         "Linear relationship of mpg and and the other variables", fluidRow(
#             column(6, selectInput("predictor", "Predictor", names(mtcars) %>% setdiff("mpg"))),
#             column(6, selectInput("degree", "Degree of polynomial", 1:3, 1)),
#             plotOutput("linear_relationship_plot")
#         )
#     ),
#     tabPanel(

#         )

#     #     mainPanel(
#     #         h3("Analysing the factors behind average consumption using the mtcars dataset")
#     # )
# )
#     )
