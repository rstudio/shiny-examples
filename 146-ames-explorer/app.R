# load packages
library(dplyr)
library(ggplot2)
library(scales)
library(ggrepel)
library(AmesHousing)
library(shiny)
library(DT)

# prepare dataset
ames <- make_ames()

# load helper scripts
source("helpers/plot_functions.R")

# load module scripts
source("modules/plot_modules.R")
source("modules/data_modules.R")

# user interface
ui <- fluidPage(

   titlePanel("Ames Housing Data Explorer"),

   fluidRow(
     column(
       width = 3,
       wellPanel(
         varselect_mod_ui("plot1_vars")
       )
     ),
     column(
       width = 6,
       scatterplot_mod_ui("plots")
     ),
     column(
       width = 3,
       wellPanel(
         varselect_mod_ui("plot2_vars")
       )
     )
   ),

   fluidRow(
     column(
       width = 12,
       checkboxInput("highlight_ind", "Highlight records selected?", value = FALSE),
       dataviewer_mod_ui("dataviewer")
     )
   )
)

# server logic
server <- function(input, output, session) {

  plotdf <- reactive({
    brushedPoints(ames, res$brush(), allRows = TRUE)
  })


  # execute plot variable selection modules
  plot1vars <- callModule(varselect_mod_server, "plot1_vars")
  plot2vars <- callModule(varselect_mod_server, "plot2_vars")

  # execute scatterplot module
  res <- callModule(scatterplot_mod_server,
                    "plots",
                    dataset = plotdf,
                    plot1vars = plot1vars,
                    plot2vars = plot2vars,
                    highlight_ind = reactive({ input$highlight_ind }),
                    highlight_rows = dt_highlight)

  # execute dataviewer module
  dt_highlight <- callModule(dataviewer_mod_server, "dataviewer", dataset = res$processed)
}

# Run the application
shinyApp(ui = ui, server = server)

