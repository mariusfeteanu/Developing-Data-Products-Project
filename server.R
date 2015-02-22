library(shiny)
library(datasets)

data(mtcars)

mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
mtcars$am <- factor(mtcars$am,labels=c('Automatic','Manual'))

shinyServer(function(input, output, session) {
    
    
    output$independent <- renderUI({
        checkboxGroupInput("independent", "Independent Variables:",names(mtcars)[!names(mtcars) %in% input$dependent],names(mtcars)[!names(mtcars) %in% input$dependent])
    })
    
    runRegression <- reactive({
        lm(as.formula(paste(input$dependent," ~ ",paste(input$independent,collapse="+"))),data=mtcars)
    })
    
    output$regTab <- renderTable({
        input$submitButton
        isolate(
        if(!is.null(input$independent)){
            summary(runRegression())$coefficients
        } else {
            print(data.frame(Warning="Please select Model Parameters."))
        })
    })
    
    output$rsq <- renderText({
        input$submitButton
        isolate(
            if(!is.null(input$independent)){
                summary(runRegression())$r.squared
            } 
        )
    })
    
    
    
    output$residualAnalysis <- renderPlot({
        input$submitButton
        isolate(
        if(!is.null(input$independent)){
            par(mfrow = c(2, 2))
            plot(runRegression())
        })
    })
    
})