plot_labeller <- function(l, varname) {
  if (varname == "Sale_Price") {
    res <- dollar(l)
  } else {
    res <- comma(l)
  }
  return(res)
}

is_brushed <- function(dataset, brush_colname = "selected_") {
  brush_colname %in% names(dataset)
}

#' Produce scatterplot with sales data and a single continuous variable
#'
#' @param data data frame with variables necessary for scatterplot.
#' @param xvar variable (string format) to be used on x-axis.
#' @param yvar variable (string format) to be used on y-axis.
#' @param facetvar optional variable (string format) to use for facetted version of plot.
#' @param highlight_ind boolean indicating whether to perform annotation of data points
#'   on the plot. Default is \code{FALSE}.
#' @param highlight_rows optional vector of row ids corresponding to which data point(s)
#'   to highlight in the scatterplot. Default value is \code{NULL}.
#'
#' @return {\code{ggplot2} object for the scatterplot.
#' @export
#'
#' @examples
#' plot_obj <- scatter_sales(data = ames, xvar = "Lot_Frontage")
#' plot_obj
scatter_sales <- function(dataset, 
                          xvar, 
                          yvar, 
                          facetvar = NULL, 
                          highlight_ind = FALSE, 
                          highlight_rows = NULL,
                          point_colors = c("black", "#66D65C")) {
  
  x <- rlang::sym(xvar)
  y <- rlang::sym(yvar)
  
  p <- ggplot(dataset, aes(x = !!x, y = !!y)) 
  
  p <- p +
    geom_point(aes(color = selected_)) +
    scale_color_manual(values = point_colors, guide = FALSE) +
    scale_x_continuous(labels = function(l) plot_labeller(l, varname = xvar)) +
    scale_y_continuous(labels = function(l) plot_labeller(l, varname = yvar)) +
    theme(axis.title = element_text(size = rel(1.2)),
          axis.text = element_text(size = rel(1.1)))
  
  if (!is.null(facetvar)) {
    fvar <- rlang::sym(facetvar)
    
    p <- p +
      facet_wrap(fvar)
  }
  
  return(p)
}
