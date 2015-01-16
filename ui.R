library(shiny)
library(markdown)

# Load Motor Trend Data set
data(mtcars)

# Create a list of choices for features selection
choice_list <- names(mtcars)[-1]
names(choice_list) <- c("Number of cylinders",
                        "Displacement",
                        "Gross horsepower",
                        "Rear axle ratio",
                        "Weight",
                        "1/4 mile time",
                        "V/Straight",
                        "Transmission",
                        "Number of forward gears",
                        "Number of carburetors")

shinyUI(fluidPage(
        titlePanel("Miles per Gallon Predictor"),
        fluidRow(
                tabsetPanel(id="tabs", type="tabs", selected="Model",
                        tabPanel("Model",
                                column(3,
                                       wellPanel(
                                               checkboxGroupInput("predictors", label = h4("Features"), 
                                                                  choices = choice_list,
                                                                  selected = "cyl"),
                                               actionButton("goButton", "Calculate Model")
                                        )
                                ),
                                column(9,
                                        wellPanel(
                                                h4("Summary"),
                                                verbatimTextOutput("summary"),
                                                h4("Residuals Plot"),
                                                plotOutput("plot")
                                        )
                                )
                        ),        
                        tabPanel("Predictor",
                                column(3,
                                       wellPanel(
                                                h4("Predictors"),
                                                uiOutput("controls")
                                      )
                                ),
                                column(9,
                                       wellPanel(
                                               h4("Values"),
                                                verbatimTextOutput("values"),
                                               h4("Prediction"),
                                               verbatimTextOutput("prediction")
                                       )
                                )
                        ),
                        tabPanel("Help",
                                 wellPanel(
                                         includeMarkdown("README.md")
                                         ))
                )
        )
))