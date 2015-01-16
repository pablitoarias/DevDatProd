
# Load the Motor Trend data set
data(mtcars)
columns <- c(2,8,10,11) # Columns to convert to factors
mtcars[, columns] <- lapply(mtcars[,columns], as.factor) 
mtcars[, 9] <- factor(mtcars[, 9], labels=c("Auto", "Manual"))
predict_mtcars <- mtcars[1,]
rownames(predict_mtcars) <-NULL
shinyServer(function(input, output, session) {
        output$controls <- renderUI({
                if (is.null(input$tabs)) return()
                list(
                        if(any(input$predictors == "cyl")) 
                                sliderInput("cyl", 
                                            "Number of cylinders:", 
                                            min = 4, 
                                            max = 8,
                                            value = 4,
                                            step = 2),
                        if(any(input$predictors=="disp")) 
                                sliderInput("disp", 
                                            "Displacement:", 
                                            min = min(mtcars$disp), 
                                            max = max(mtcars$disp),
                                            value = min(mtcars$disp)),
                         if(any(input$predictors=="hp"))
                                sliderInput("hp", 
                                    "Gross Horsepower:", 
                                    min = min(mtcars$hp), 
                                    max = max(mtcars$hp),
                                    value = min(mtcars$hp)),
                        if(any(input$predictors=="drat"))
                                sliderInput("drat", 
                                    "Rear axle ratio:", 
                                    min = min(mtcars$drat), 
                                    max = max(mtcars$drat),
                                    value = min(mtcars$drat)),
                        if(any(input$predictors=="wt"))
                                sliderInput("wt", 
                                    "Weight:", 
                                    min = min(mtcars$wt), 
                                    max = max(mtcars$wt),
                                    value = min(mtcars$wt)),
                        if(any(input$predictors=="qsec"))
                                sliderInput("qsec", 
                                    "1/4 mile time:", 
                                    min = min(mtcars$qsec), 
                                    max = max(mtcars$qsec),
                                    value = min(mtcars$qsec)),
                        if(any(input$predictors=="vs"))
                                selectInput("vs", label = "Engine shape:", 
                                    choices = list("V" = 0, "Straight" = 1), 
                                    selected = 0),
                        if(any(input$predictors=="am"))
                                selectInput("am", label = "Transmission:", 
                                    choices = list("Automatic" = "Auto", "Manual" = "Manual"), 
                                    selected = 0),
                        if(any(input$predictors=="gear"))
                                sliderInput("gear", 
                                    "Gears:", 
                                    min = 3, 
                                    max = 5,
                                    value = 3,
                                    step=1),
                        if(any(input$predictors=="carb"))
                                selectInput("carb", label="Carburators:", 
                                    choices = list("1"=1,"2"=2,"3"=3,"4"=4,"6"=6,"8"),
                                    selected=1)
                )
                
        })
        
        model <- reactive({
                input$goButton
                isolate({
                        predictors <- input$predictors
                        sub_mtcars <<- mtcars[,c("mpg", predictors)]
                        lm(mpg ~ ., data=sub_mtcars)
                })
        })
        
        output$plot <- renderPlot({
                par(mfrow=c(2,2))
                plot(model())
        })
        output$summary <- renderPrint({
                summary(model())
        }) 

        observe({
                if (length(input$predictors) == 0)
                        updateCheckboxGroupInput(session, "predictors",
                                                 selected = "cyl")
        })        
        
        observe({
                if(input$tabs == "Model") return()
                if (!all(sort(input$predictors)==sort(names(sub_mtcars)[-1]))) 
                        updateTabsetPanel(session, "tabs", selected = "Model")
                
        })
        
        output$prediction <- renderPrint({
                if(!is.null(input$cyl)) predict_mtcars$cyl <- as.factor(input$cyl)
                if(!is.null(input$disp)) predict_mtcars$disp <- input$disp
                if(!is.null(input$hp)) predict_mtcars$hp <- input$hp
                if(!is.null(input$drat)) predict_mtcars$drat <-input$drat
                if(!is.null(input$wt)) predict_mtcars$wt <- input$wt
                if(!is.null(input$qsec)) predict_mtcars$qsec <- input$qsec
                if(!is.null(input$vs)) predict_mtcars$vs <- as.factor(input$vs)
                if(!is.null(input$am)) predict_mtcars$am <- as.factor(input$am)
                if(!is.null(input$gear)) predict_mtcars$gear <- as.factor(input$gear)
                if(!is.null(input$carb)) predict_mtcars$carb <- as.factor(input$carb)
                output$values <- renderPrint({
                        predict_mtcars[names(sub_mtcars[])]
                })
                paste(round(predict(model(),predict_mtcars),2), "mpg")
                    
        }) 
        
        
 
}
)