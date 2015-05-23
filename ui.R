#
# Shiny application to plot a linear regression model of gas prices 1982 - 2014
#
# Demonstrates the impact of adding an x squared term 
# to the simple linear regression model y = mx + b

require(shiny)


shinyUI(pageWithSidebar(
  headerPanel('Gas Prices'),
  sidebarPanel(
    helpText("Select at least a 20 year range to view CI and PI curves."),
    helpText("Plot displayed if from date < to date."),
	selectInput('fromdate', 'From', 1982:2013),
    selectInput('todate', 'To', 1983:2014, selected = 2014),
    shiny::tags$hr(),
	radioButtons("equation", "Select Equation:",
             c('y = mx + b' = "x" ,
               "y = c2*x^2 + c1*x + b" = "xsquare" 
               ), selected = "xsquare"),
    checkboxInput('CI', 'Show Confidence Interval', TRUE),
    checkboxInput('PI', 'Show Prediction Interval', TRUE),
    shiny::tags$hr(),
    checkboxInput('help', 'Show Help', TRUE)
),
  mainPanel(
	"Linear Regression Plot",
	plotOutput("mylmPlot"), 
	conditionalPanel(
        condition = "input.help == true",
        verbatimTextOutput("textHelp")
	)	)
))