library(shiny)

renderInputs <- function(prefix) {
  wellPanel(
    fluidRow(
      column(6,
        sliderInput(paste0(prefix, "_", "n_obs"), "Number of observations (in Years):", min = 0, max = 40, value = 20),
        sliderInput(paste0(prefix, "_", "start_capital"), "Initial capital invested :", min = 100000, max = 10000000, value = 2000000, step = 100000, pre = "$", sep = ","),
        sliderInput(paste0(prefix, "_", "annual_mean_return"), "Annual investment return (in %):", min = 0.0, max = 30.0, value = 5.0, step = 0.5),
        sliderInput(paste0(prefix, "_", "annual_ret_std_dev"), "Annual investment volatility (in %):", min = 0.0, max = 25.0, value = 7.0, step = 0.1)
      ),
      column(6,
        sliderInput(paste0(prefix, "_", "annual_inflation"), "Annual inflation (in %):", min = 0, max = 20, value = 2.5, step = 0.1),
        sliderInput(paste0(prefix, "_", "annual_inf_std_dev"), "Annual inflation volatility. (in %):", min = 0.0, max = 5.0, value = 1.5, step = 0.05),
        sliderInput(paste0(prefix, "_", "monthly_withdrawals"), "Monthly capital withdrawals:", min = 1000, max = 100000, value = 10000, step = 1000, pre = "$", sep = ","),
        sliderInput(paste0(prefix, "_", "n_sim"), "Number of simulations:", min = 0, max = 2000, value = 200)
      )
    ),
    p(actionButton(paste0(prefix, "_", "recalc"),
      "Re-run simulation", icon("random")
    ))
  )
}

# Define UI for application that plots random distributions
fluidPage(theme="simplex.min.css",
  tags$style(type="text/css",
    "label {font-size: 12px;}",
    ".recalculating {opacity: 1.0;}"
  ),

  # Application title
  tags$h2("Retirement: simulating wealth with random returns, inflation and withdrawals"),
  p("An adaptation of the",
    tags$a(href="https://systematicinvestor.wordpress.com/2013/04/06/retirement-simulating-wealth-with-random-returns-inflation-and-withdrawals-shiny-web-application/", "retirement app"),
    "from",
    tags$a(href="http://systematicinvestor.wordpress.com/", "Systematic Investor"),
    "to demonstrate the use of Shiny's new grid options."),
  hr(),

  fluidRow(
    column(6, tags$h3("Scenario A")),
    column(6, tags$h3("Scenario B"))
  ),
  fluidRow(
    column(6, renderInputs("a")),
    column(6, renderInputs("b"))
  ),
  fluidRow(
    column(6,
      plotOutput("a_distPlot", height = "600px")
    ),
    column(6,
      plotOutput("b_distPlot", height = "600px")
    )
  )
)
