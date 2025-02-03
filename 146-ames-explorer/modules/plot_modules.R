#' Scatterplot module user interface
#'
#' @param id, character used to specify namespace, see \code{shiny::\link[shiny]{NS}}
#'
#' @return a \code{shiny::\link[shiny]{tagList}} containing UI elements
#' @export
#'
#' @examples
scatterplot_mod_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        width = 6,
        plotOutput(
          ns("plot1"),
          brush = brushOpts(
            id = ns("brush"),
            resetOnNew = FALSE
          )
        )
      ),
      column(
        width = 6,
        plotOutput(
          ns("plot2"),
          brush = brushOpts(
            id = ns("brush"),
            resetOnNew = FALSE
          )
        )
      )
    )
  )
}

#' Scatterplot module server-side processing
#'
#' This module produces a scatterplot with the sales price against a variable selected by the user.
#'
#' @param input,output,session standard \code{shiny} boilerplate.
#' @param dataset data frame (non-reactive) with variables necessary for scatterplot.
#' @param plot1_vars reactive list of plot 1 x variable, y variable, and grouping variable.
#' @param plot2_vars reactive list of plot 2 x variable, y variable, and grouping variable.
#' @param highlight_ind boolean indicating whether to perform annotation of data points
#'   on the plot. Default is \code{FALSE}.
#'
#' @return list with following components:
#' \describe{
#'   \item{plot_data}{reactive data frame containing only the \code{xvar} and \code{yvar} variables}.
#'   \item{plot_object}{reactive \code{ggplot2} object for the scatterplot}.
#' }
#' @export
#'
#' @examples
scatterplot_mod_server <- function(input,
                                   output,
                                   session,
                                   dataset,
                                   plot1vars,
                                   plot2vars,
                                   label = reactive(FALSE)) {

  dat <- reactive({
    brushedPoints(dataset, input$brush, allRows = TRUE)
  })

  output$plot1 <- renderPlot({
    scatter_sales(
      dat(),
      xvar = plot1vars$xvar(),
      yvar = plot1vars$yvar(),
      facetvar = plot1vars$facetvar(),
      label = label()
    )
  })

  output$plot2 <- renderPlot({
    scatter_sales(
      dat(),
      xvar = plot2vars$xvar(),
      yvar = plot2vars$yvar(),
      facetvar = plot2vars$facetvar(),
      label = label()
    )
  })

  dat
}
