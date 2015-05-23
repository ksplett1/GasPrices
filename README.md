
This R program is a Shiny application to plot a linear regression model of gas prices 1982 - 2014.

The program demonstrates the impact of adding an x squared term 
to the simple linear regression model y = mx + b

Please refer to comments at the beginning of the server.R file for more information about the program.

Please refer to the following sections for information about the build process. To run the Shiny application, browse to https://ksplett1.shinyapps.io/code/ 
  
    *****************************************************

To develop a Shiny application in RStudio:

from http://www.stat.cmu.edu/~hseltman/RTips.html

1. Start R in any directory
2. Install shiny using install.packages("shiny") if it has not previously been installed.
3. Run library("shiny") once per R session (or place this command in the .First() function).
4. Place files named ui.R and server.R in the directory (or in another directory, e.g., named "foo"). You can create these files from scratch, or you may want to start with the files linked here, which implement a simple histogram vs. boxplot app.
5. From R in your working directory, run runApp() (or runApp("foo") if the ui.R and server.R files were placed in another directory).
6. Interact with the app in the supplied test window. In this window you can click "Open in Browser" to open the app in your default browser. Certain functions, such as downloading a file using downloadButton() work only in a browser, and not in the test window.
7. Make whatever additions / changes you need to either file to change the app so that it does what you want it to do (see the official tutorial and Inside R for details).
8. Note that you can change the ui.R and/or server.R files while the app is running, save the changes, and click "Reload" in your browser to see the effects of the changes without quitting the app. (Check the R console for possible error messages.)
9. To quit the app, use the "escape" key in the R console window or close the test window or browser window.

    *****************************************************

Before publishing a Shiny application to the RStudio Shiny server:

Follow the steps here:
http://shiny.rstudio.com/articles/shinyapps.html

(from the web page: 
Shinyapps.io is a platform as a service (PaaS) for hosting Shiny web apps (applications). This guide will show you how to create a shinyapps.io account and deploy your first application to the cloud.)

    *****************************************************

To publish the Shiny application after the Shinyapps.io account has been created:

In RStudio:
1. Set the working directory  ( setwd() )
2. Execute the Shiny deploy application command.
library(shinyapps)
shinyapps::deployApp("C:/Users/ksplett1/dataproducts/project/code")

or in RStudio:
1. Set the working directory  ( setwd() )
2. Run the Shiny application:
library(shiny)
runApp()
3. Click on Publish on the top of the runApp page

    *****************************************************

To run the Shiny application after the Shiny application has been published:

1. Browse to https://ksplett1.shinyapps.io/code


