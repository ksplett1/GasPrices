#
# Shiny application to plot a linear regression model of gas prices 1982 - 2014
#
# Demonstrates the impact of adding an x squared term 
# to the simple linear regression model y = mx + b

if (!"graphics" %in% installed.packages()) install.packages("ggplot2")
if (!"doBy" %in% installed.packages()) install.packages("doBy")
if (!"utils" %in% installed.packages()) install.packages("utils")
if (!"stats" %in% installed.packages()) install.packages("stats")

require(shiny)
require(ggplot2)
require(doBy)
require(utils)
require(stats)

# data set available here:
# Browse to http://data.bls.gov/cgi-bin/surveymost?ap and download the data set 
# called Gasoline, Unleaded Regular - APU000074714 for years 1982 – 2014. 
#
# example records from data set
#   Year   Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
# 1 1982 1.358 1.334 1.284 1.225 1.237 1.309 1.331 1.323 1.307 1.295 1.283 1.260
# 2 1983 1.230 1.187 1.152 1.215 1.259 1.277 1.288 1.285 1.274 1.255 1.241 1.231

# setwd("C:/Users/ksplett1/dataproducts/project/code")

myHelp <- "Help about the linear regression model: 

This plot shows the annual trend of average gas prices.
The objectives for the linear regression analysis are: 

*	Predict annual average gas price using a linear regression model 
    (a best-fit line through the data points)
*	Build a simple linear regression model (y = mx + b)
      where y is a variable that represents the average gas prices
	             for a year
            x is a variable that represents a year number 
		             (1 = 1st year; 2 = 2nd year; etc)
*	Demonstrate the impact of including a x^2 term on the 
        model performance (year squared)
*	Interactive exploration: 
		** number of years included in the model 
		** option to include/exclude the x^2 term 
		** options to include/exclude confidence and prediction intervals 

Results of the linear regression model show:  

* The linear relationship between year and average gas price  
* Confidence and prediction intervals  
* Scatter Plot with Regression Line, Confidence Interval, 
      and Prediction Interval  

What is a confidence interval? 
The confidence interval is a range that represents the amount of 
uncertainty associated with a sampling method for a sample estimate 
that estimates a population parameter. 

For example, a 90% confidence level means that we would expect 90% 
of the interval estimates to include the population parameter. 

What is a prediction interval? 
A Prediction interval is where the next sampled data point is expected 
to be. The prediction interval describes the distribution of values, 
not the uncertainty in determining the population parameter.  

The prediction interval accounts for both the uncertainty in knowing 
the value of the population parameter, plus data scatter. For that 
reason, a prediction interval is always wider than a confidence 
interval.  

A 95% prediction interval means there is a 50% chance that you'd see 
the value within the interval in more than 95% of the samples, and a 
50% chance that you'd see the value within the interval in less than 
95% of the samples.
"

data <- "1982,1.358,1.334,1.284,1.225,1.237,1.309,1.331,1.323,1.307,1.295,1.283,1.26
1983,1.23,1.187,1.152,1.215,1.259,1.277,1.288,1.285,1.274,1.255,1.241,1.231
1984,1.216,1.209,1.21,1.227,1.236,1.229,1.212,1.196,1.203,1.209,1.207,1.193
1985,1.148,1.131,1.159,1.205,1.231,1.241,1.242,1.229,1.216,1.204,1.207,1.208
1986,1.194,1.12,0.981,0.888,0.923,0.955,0.89,0.843,0.86,0.831,0.821,0.823
1987,0.862,0.905,0.912,0.934,0.941,0.958,0.971,0.995,0.99,0.976,0.976,0.961
1988,0.933,0.913,0.904,0.93,0.955,0.955,0.967,0.987,0.974,0.957,0.949,0.93
1989,0.918,0.926,0.94,1.065,1.119,1.114,1.092,1.057,1.029,1.027,0.999,0.98
1990,1.042,1.037,1.023,1.044,1.061,1.088,1.084,1.19,1.294,1.378,1.377,1.354
1991,1.247,1.143,1.082,1.104,1.156,1.16,1.127,1.14,1.143,1.122,1.134,1.123
1992,1.073,1.054,1.058,1.079,1.136,1.179,1.174,1.158,1.158,1.154,1.159,1.136
1993,1.117,1.108,1.098,1.112,1.129,1.13,1.109,1.097,1.085,1.127,1.113,1.07
1994,1.043,1.051,1.045,1.064,1.08,1.106,1.136,1.182,1.177,1.152,1.163,1.143
1995,1.129,1.12,1.115,1.14,1.2,1.226,1.195,1.164,1.148,1.127,1.101,1.101
1996,1.129,1.124,1.162,1.251,1.323,1.299,1.272,1.24,1.234,1.227,1.25,1.26
1997,1.261,1.255,1.235,1.231,1.226,1.229,1.205,1.253,1.277,1.242,1.213,1.177
1998,1.131,1.082,1.041,1.052,1.092,1.094,1.079,1.052,1.033,1.042,1.028,0.986
1999,0.972,0.955,0.991,1.177,1.178,1.148,1.189,1.255,1.28,1.274,1.264,1.298
2000,1.301,1.369,1.541,1.506,1.498,1.617,1.593,1.51,1.582,1.559,1.555,1.489
2001,1.472,1.484,1.447,1.564,1.729,1.64,1.482,1.427,1.531,1.362,1.263,1.131
2002,1.139,1.13,1.241,1.407,1.421,1.404,1.412,1.423,1.422,1.449,1.448,1.394
2003,1.473,1.641,1.748,1.659,1.542,1.514,1.524,1.628,1.728,1.603,1.535,1.494
2004,1.592,1.672,1.766,1.833,2.009,2.041,1.939,1.898,1.891,2.029,2.01,1.882
2005,1.823,1.918,2.065,2.283,2.216,2.176,2.316,2.506,2.927,2.785,2.343,2.186
2006,2.315,2.31,2.401,2.757,2.947,2.917,2.999,2.985,2.589,2.272,2.241,2.334
2007,2.274,2.285,2.592,2.86,3.13,3.052,2.961,2.782,2.789,2.793,3.069,3.02
2008,3.047,3.033,3.258,3.441,3.764,4.065,4.09,3.786,3.698,3.173,2.151,1.689
2009,1.787,1.928,1.949,2.056,2.265,2.631,2.543,2.627,2.574,2.561,2.66,2.621
2010,2.731,2.659,2.78,2.858,2.869,2.736,2.736,2.745,2.704,2.795,2.852,2.985
2011,3.091,3.167,3.546,3.816,3.933,3.702,3.654,3.63,3.612,3.468,3.423,3.278
2012,3.399,3.572,3.868,3.927,3.792,3.552,3.451,3.707,3.856,3.786,3.488,3.331
2013,3.351,3.693,3.735,3.59,3.623,3.633,3.628,3.6,3.556,3.375,3.251,3.277
2014,3.32,3.364,3.532,3.659,3.691,3.695,3.633,3.481,3.403,3.182,2.887,2.56"

    con <- textConnection(data)
    g <- isolate( read.csv(con) )
    close(con)
    colnames(g) <- c("Year","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

	yr_mean <- summaryBy( Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec ~ Year, 
	data=g, FUN=mean)
	colnames(yr_mean) <- c("Year", "avg")
	
	#add average and index columns to gas_prices
	g$avg <- yr_mean$avg
	g$ix <- seq.int(nrow(g))
	
	# add a squared term to the data set
	g$ixsq <- seq.int(nrow(g)) * seq.int(nrow(g))

#    ********************************************************

shinyServer(function(input, output, session){
  
myX <- reactive ( input$fromdate )
myY <- reactive ( input$todate )
myEquation <- reactive ( input$equation )
myCI <- reactive ( input$CI )
myPI <- reactive ( input$PI )

output$textHelp <- renderText( myHelp )

output$mylmPlot <- renderPlot({ 
#   debug
#	print(paste('mylm: fromdate = ', input$fromdate))    
#	print(paste('mylm: todate =   ', input$todate))   

    if ( myX() < myY() )  {
	    grun <- g[g$Year >= myX() & g$Year <= myY(), ]
	
	    if ( myEquation() == 'x' ) {	
		    # create a linear regression model for output avg and input index
		    fit <- lm(avg ~ ix, data=grun)
	    }
	    else {
		    # create a multiple linear regression model for output avg and input index and index squared.
		    fit <- lm(avg ~ ix + ixsq, data=grun)
	    }

	    # predicted values
	    fit_est <-  predict(fit) 
		
		# workaround for Shiny bizarre error -  input string 1 is invalid in this locale
		Sys.setlocale(locale="C")

	    # calculate CI and PI limits
	    fit_conf =  predict(fit, interval = "confidence")
	    conflwr <- fit_conf[,c("lwr")]
	    confupr <- fit_conf[,c("upr")]
		# workaround for Shiny bizarre error -  input string 1 is invalid in this locale
		Sys.setlocale(locale="C")
	    fit_pred = isolate( predict(fit, interval = "prediction") )
	    predlwr <- fit_pred[,c("lwr")]
	    predupr <- fit_pred[,c("upr")] 
 
	    # plot linear regression line, CI, and PI
	    plot(grun$ix, grun$avg, xlab = "Number Years after Start Year", ylab = "Avg Price Gas")
	    lines( fit_est )
	    if ( myCI() == TRUE ) {
		    points(conflwr, col = "blue", type = "l")
		    points(confupr, col = "blue", type = "l")
	    }
	    if ( myPI() == TRUE ) {
		    points(predlwr, col = "red", type = "l")
		    points(predupr, col = "red", type = "l")
	    }
	}
  })

})