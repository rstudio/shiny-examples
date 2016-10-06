# Load packages -----------------------------------------------------
library(shiny)
library(highcharter)
library(dplyr)
library(tidyr)

# Load data ---------------------------------------------------------
births <- read.csv("data/births.csv")

# Determine years in data -------------------------------------------
years <- unique(births$year)

# UI ----------------------------------------------------------------
ui <- fluidPage(
  
  # App title -------------------------------------------------------
  titlePanel("The Friday the 13th effect"),
  
  # Sidebar layout with a input and output definitions --------------
  sidebarLayout(

    # Inputs --------------------------------------------------------    
    sidebarPanel(
           
           sliderInput("year", 
                       label = "Year",
                       min = min(years), 
                       max = max(years), 
                       step = 1,
                       sep = "",
                       value = range(years)),
           
           selectInput("plot_type", 
                       label = "Plot type",
                       choices = c("Scatter" = "scatter", 
                                   "Bar" = "column", 
                                   "Line" = "line")),
           selectInput("theme", 
                       label = "Theme",
                       choices = c("No theme", 
                                   "Chalk" = "chalk",
                                   "Dark Unica" = "darkunica", 
                                   "Economist" = "economist",
                                   "FiveThirtyEight" = "fivethirtyeight", 
                                   "Gridlight" = "gridlight", 
                                   "Handdrawn" = "handdrawn", 
                                   "Sandsignika" = "sandsignika"))
    ),
    
    # Output --------------------------------------------------------    
    mainPanel(
      highchartOutput("hcontainer", height = "500px")
    )
    
  )
)


# SERVER ------------------------------------------------------------
server = function(input, output) {
  
  # Calculate differences between 13th and avg of 6th and 20th ------
  diff13 <- reactive({
    births %>%
      filter(between(year, input$year[1], input$year[2])) %>%
      filter(date_of_month %in% c(6, 13, 20)) %>%
      mutate(day = ifelse(date_of_month == 13, "thirteen", "not_thirteen")) %>%
      group_by(day_of_week, day) %>%
      summarise(mean_births = mean(births)) %>%
      arrange(day_of_week) %>%
      spread(day, mean_births) %>%
      mutate(diff_ppt = ((thirteen - not_thirteen) / not_thirteen) * 100)
  })
  
  # Text string of selected years for plot subtitle -----------------
  selected_years_to_print <- reactive({
    if(input$year[1] == input$year[2]) { 
      as.character(input$year[1])
    } else {
      paste(input$year[1], " - ", input$year[2])
    }
  })
 
  # Highchart -------------------------------------------------------
  output$hcontainer <- renderHighchart({
    
    hc <- highchart() %>%
      hc_add_series(data = diff13()$diff_ppt, 
                    type = input$plot_type,
                    name = "Difference, in ppt",
                    showInLegend = FALSE) %>%
      hc_yAxis(title = list(text = "Difference, in ppt"), 
               allowDecimals = FALSE) %>%
      hc_xAxis(categories = c("Monday", "Tuesday", "Wednesday", "Thursday", 
                              "Friday", "Saturday", "Sunday"),
               tickmarkPlacement = "on",
               opposite = TRUE) %>%
      hc_title(text = "The Friday the 13th effect",
               style = list(fontWeight = "bold")) %>% 
      hc_subtitle(text = paste("Difference in the share of U.S. births on 13th 
                               of each month from the average of births on the 6th 
                               and the 20th,",
                               selected_years_to_print())) %>%
      hc_tooltip(valueDecimals = 4,
                 pointFormat = "Day: {point.x} <br> Diff: {point.y}") %>%
      hc_credits(enabled = TRUE, 
                 text = "Sources: CDC/NCHS, SOCIAL SECURITY ADMINISTRATION",
                 style = list(fontSize = "10px"))
    
    # Determine theme and apply to highchart ------------------------
    if (input$theme != "No theme") {
      theme <- switch(input$theme,
                      chalk = hc_theme_chalk(),
                      darkunica = hc_theme_darkunica(),
                      fivethirtyeight = hc_theme_538(),
                      gridlight = hc_theme_gridlight(),
                      handdrawn = hc_theme_handdrawn(),
                      economist = hc_theme_economist(),
                      sandsignika = hc_theme_sandsignika()
      )
      hc <- hc %>%
        hc_add_theme(theme)
    }
    
    # Print highchart -----------------------------------------------
    hc
  })
  
}

# Run app -----------------------------------------------------------
shinyApp(ui = ui, server = server)