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
#' @param highlight_rows optional vector of row ids corresponding to which data point(s)
#'   to highlight in the scatterplot. Default value is \code{NULL}.
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
                                   highlight_ind = FALSE, 
                                   highlight_rows = NULL) {
  
  # reactive data frame with new column indicating if rows were 
  # selected in brush
  processed <- reactive({
    res <- brushedPoints(dataset(), input$brush, allRows = TRUE)
    return(res)
  })
  
  
  plot1_obj <- reactive({
    p <- scatter_sales(dataset(), 
                  xvar = plot1vars$xvar(), 
                  yvar = plot1vars$yvar(), 
                  facetvar = plot1vars$facetvar(),
                  highlight_ind = highlight_ind(),
                  highlight_rows = highlight_rows())
    
    # was: if (highlight_ind())
    if (highlight_ind()) {
      validate(
        need(
          any(dataset()$selected_), "Brush at least one point on a plot"
        )
      )
      df <- dataset() %>%
        filter(selected_) %>%
        slice(highlight_rows())
      
      p <- p +
        geom_label_repel(data = df, aes(label = Sale_Price))
    }
    
    return(p)
  })
  
  plot2_obj <- reactive({
    p <- scatter_sales(dataset(), 
                  xvar = plot2vars$xvar(), 
                  yvar = plot2vars$yvar(), 
                  facetvar = plot2vars$facetvar(),
                  highlight_ind = highlight_ind(),
                  highlight_rows = highlight_rows())
    
    if (highlight_ind()) {
      validate(
        need(
          any(dataset()$selected_), "Brush at least one point on a plot"
        )
      )
      df <- dataset() %>%
        filter(selected_) %>%
        slice(highlight_rows())
      
      p <- p +
        geom_label_repel(data = df, aes(label =Sale_Price))
    }
    
    return(p)
  })
  
  output$plot1 <- renderPlot({
    plot1_obj()
  })
  
  output$plot2 <- renderPlot({
    plot2_obj()
  })
  
  return(
    list(
      processed = processed,
      brush = reactive({ input$brush })
    )
  )
}
