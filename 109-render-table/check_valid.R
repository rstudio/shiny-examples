# Helper functions to check that each argument is valid.
# This is important to decrease security vulnerabilities
# given that the input values are being printed back into
# the app using the HTML() function.

# Check dataset is valid
dataset <- function() {
  valid <- c("rock", "pressure", "cars", "mock")
  if (input$dataset %in% valid) return(input$dataset)
  else stop("Invalid Data argument")
}

# Check obs is valid
obs <- function() {
  if (is.numeric(input$obs)) return(input$obs)
  else stop("Invalid Rows argument")
}

# Convert input$format into the three booleans required by
# the renderTable() function
striped <- function() "striped" %in% input$format
bordered <- function() "bordered" %in% input$format
hover <- function() "hover" %in% input$format

# Check spacing is valid
spacing <- function() {
  valid <- c("xs", "s", "m", "l")
  if (input$spacing %in% valid) return(input$spacing)
  else stop("Invalid spacing argument")
}

# Check width is valid
width <- function() {
  valid <- c("auto", "100%", "75%", "300", "300px", "10cm")
  if (input$width %in% valid) return(input$width)
  else stop("Invalid width argument")
}

# Check rownames and colnames are valid
rownames <- function() as.logical(input$rownames)
colnames <- function() as.logical(input$colnames)

# Check align is valid
align <- function() {
  al <- input$align
  req(al)
  if (al == "NULL") return(NULL)
  if (!grepl("[^lcr\\?]", al)) return(al)
  else stop("Invalid align argument")
}

# Check digits is valid
digits <- function() {
  di <- input$digits
  if (di == "NULL") return(NULL)
  valid <- c("3", "2", "0", "-2", "-3")
  if (di %in% valid) return(as.numeric(di))
  else stop("Invalid digits argument")
}

# Check na is valid
na <- function() {
  valid <- c("NA", "missing", "-99")
  if (input$na %in% valid) return(input$na)
  else stop("Invalid NA argument")
}
