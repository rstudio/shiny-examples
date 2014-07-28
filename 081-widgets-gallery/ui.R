shinyUI(fluidPage(
  
  tags$head(tags$style(HTML("
    .shiny-text-output {
      background-color:#fff;
    }
  "))),
  
  h1("Shiny", span("Widgets Gallery", style = "font-weight: 300"), 
      style = "font-family: 'Source Sans Pro';
        color: #fff; text-align: center;
        background-image: url('texturebg.png');
        padding: 20px"),
  br(),
  
  fluidRow(
    column(6, offset = 3,
      p("For each widget below, the Current Value(s) window 
        displays the value that the widget provides to shinyServer. 
        Notice that the values change as you interact with the widgets.", 
        style = "font-family: 'Source Sans Pro';")
    )
  ),

  
  br(),
  
  fluidRow(
    
    column(4,
      wellPanel(
        h3("Action button"),
        actionButton("action", label = "Action"),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("action"),
        a("See Code", class = "btn btn-primary btn-md", 
          href = "https://gallery.shinyapps.io/widget-action-button/")
      )),
    
    column(4,
      wellPanel(
        h3("Single checkbox"),
        checkboxInput("checkbox", label = "Choice A", 
                      value = TRUE),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("checkbox"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-checkbox/")
      )),
    
    column(4,
      wellPanel(
        checkboxGroupInput("checkGroup", 
          label = h3("Checkbox group"), 
          choices = list("Choice 1" = 1, "Choice 2" = 2, 
                         "Choice 3" = 3),
          selected = 1),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("checkGroup"),
        a("See Code", class = "btn btn-primary btn-md", 
          href = "https://gallery.shinyapps.io/widget-check-group/")
      ))
  ),
  
  fluidRow(
        
    column(4,
      wellPanel(
        dateInput("date", label = h3("Date input"), value = "2014-01-01"),  
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("date"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-date/")
      )),
    
    column(4,
      wellPanel(
        dateRangeInput("dates", label = h3("Date range")),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("dates"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-date-range/")
      )),
    
    column(4,
      wellPanel(
        fileInput("file", label = h3("File input")),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("file"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-file/")
      ))
  ),
  
  fluidRow(
        
    column(4,
      wellPanel(
        numericInput("num", label = h3("Numeric input"), value = 1),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("num"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-numeric/")
      )),
    
    column(4,
      wellPanel(
        radioButtons("radio", label = h3("Radio buttons"),
          choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
          selected = 1),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("radio"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-radio/")
      )),
    
    column(4,
      wellPanel(
        selectInput("select", label = h3("Select box"), 
        choices = list("Choice 1" = 1, "Choice 2" = 2,
                       "Choice 3" = 3), selected = 1),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("select"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-select/")
      ))
  ),
  
  fluidRow(
    
    column(4,
      wellPanel(
        sliderInput("slider1", label = h3("Slider"), min = 0, max = 100, 
                    value = 50),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("slider1"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-slider/")
      )),
    
    column(4,
      wellPanel(
        sliderInput("slider2", label = h3("Slider range"), min = 0, 
                    max = 100, value = c(25, 75)),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("slider2"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-slider/")
      )),
    
    column(4,
      wellPanel(
        textInput("text", label = h3("Text input"), 
                  value = "Enter text..."),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("text"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/widget-text/")
    )) 
  )

))