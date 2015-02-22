library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Developing Data Products - Shiny Regression Model Builder"),
    
    sidebarPanel(
        p("The app allows you check if certain performance characteristics of a car a well predicted by its specs."),
        actionButton("submitButton", "Fit linear model"),
        selectInput("dependent", "Dependent Variable:", c("Miles/(US) gallon" = "mpg", "Gross horsepower" = "hp", "1/4 mile time" = "qsec")),
        uiOutput("independent")
    ),
    
    
    
    mainPanel(p("R-Squared:"), textOutput("rsq"),
                tableOutput("regTab"),
                plotOutput("residualAnalysis")
              )
))