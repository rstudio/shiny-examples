#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

if (!exists("compute_bins")){
    # At the time of writing, shiny.autoload.r is still opt-in. Unfortunately there's not a great
    # way to trigger that in shinytest since we plan to make it the default soon anyways.
    # So for now, we'll just workaround that by manually sourcing the file if necessary
    warning("R/ dir was not automatically loaded. Sourcing ourselves.")
    source("R/compute-bins.R")
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- datasets[[input$dataset]]

        bins <- compute_bins(x)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

})
