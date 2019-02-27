#' Variable selection for plot user interface
#'
#' @param id, character used to specify namespace, see \code{shiny::\link[shiny]{NS}}
#'
#' @return a \code{shiny::\link[shiny]{tagList}} containing UI elements
varselect_mod_ui <- function(id) {
  ns <- NS(id)
  
  # define choices for X and Y variable selection
  var_choices <- list(
    `Sale price` = "Sale_Price",
    `Total basement square feet` = "Total_Bsmt_SF",
    `First floor square feet` = "First_Flr_SF",
    `Lot Frontage` = "Lot_Frontage",
    `Lot Area` = "Lot_Area",
    `Masonry vaneer area` = "Mas_Vnr_Area",
    `1st floor square feet` = "First_Flr_SF",
    `2nd floor square feet` = "Second_Flr_SF",
    `Low quality finished square feet` = "Low_Qual_Fin_SF",
    `Above grade living area square feet` = "Gr_Liv_Area",
    `Garage area square feet` = "Garage_Area"
  )
  
  # assemble UI elements
  tagList(
    selectInput(
      ns("xvar"),
      "Select X variable",
      choices = var_choices,
      selected = var_choices[[4]]
    ),
    selectInput(
      ns("yvar"),
      "Select Y variable",
      choices = var_choices,
      selected = var_choices[[1]]
    ),
    selectInput(
      ns("groupvar"),
      "Select facet variable",
      choices = list(
        `None` = "",
        `House Style` = "House_Style",
        `Roof Style` = "Roof_Style",
        `Land Contour` = "Land_Contour",
        `Lot Shape` = "Lot_Shape",
        `Basement Exposure` = "Bsmt_Exposure",
        `Central Air` = "Central_Air",
        `Overall Condition` = "Overall_Cond"
      )
    )
  )
}

#' Variable selection module server-side processing
#'
#' @param input,output,session standard \code{shiny} boilerplate
#'
#' @return list with following components
#' \describe{
#'   \item{xvar}{reactive character indicating x variable selection}
#'   \item{yvar}{reactive character indicating y variable selection}
#'   \item{facetvar}{reactive character indicating variable used for defining plot facets}
#' }
varselect_mod_server <- function(input, output, session) {

  return(
    list(
      xvar = reactive({ input$xvar }),
      yvar = reactive({ input$yvar }),
      facetvar = reactive({ 
        if (input$groupvar == "") {
          return(NULL)
        } else {
          return(input$groupvar) 
        }
      })
    )
  )
}


#' Data viewer user interface
#'
#' @param id, character used to specify namespace, see \code{shiny::\link[shiny]{NS}}
#'
#' @return a \code{shiny::\link[shiny]{tagList}} containing UI elements
dataviewer_mod_ui <- function(id) {
  ns <- NS(id)
  tagList(
    DT::DTOutput(ns("table"))
  )
}

#' Data viewer module server-side processing
#'
#' @param input,output,session standard \code{shiny} boilerplate
#' @param dataset data frame (reactive) used in scatterplots as produced by
#'   the \code{brushedPoints} function in the scatterplot module
#'
#' @return reactive vector of row IDs corresponding to the current view in the 
#'   datatable widget.
dataviewer_mod_server <- function(input, output, session, dataset) {
  
  cols_select <- c("Year_Built", "Year_Sold", "Sale_Price", "Sale_Condition", "Lot_Frontage", "House_Style", 
                   "Lot_Shape", "Overall_Cond", "Overall_Qual")
  
  output$table <- renderDT({
    filter(dataset(), selected_) %>%
      select(one_of(cols_select))
  },
  filter = 'top',
  selection = "none")
  
  # return highlight indicator and vector of row IDs selected by datatable filters
  reactive({ input$table_rows_all })
}
