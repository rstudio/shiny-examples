fluidPage(
  
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
        verbatimTextOutput("actionOut"),
        a("See Code", class = "btn btn-primary btn-md", 
          href = "https://gallery.shinyapps.io/068-widget-action-button/")
      )),
    
    column(4,
      wellPanel(
        h3("Single checkbox"),
        checkboxInput("checkbox", label = "Choice A", 
                      value = TRUE),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("checkboxOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/070-widget-checkbox/")
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
        verbatimTextOutput("checkGroupOut"),
        a("See Code", class = "btn btn-primary btn-md", 
          href = "https://gallery.shinyapps.io/069-widget-check-group/")
      ))
  ),
  
  fluidRow(
        
    column(4,
      wellPanel(
        dateInput("date", label = h3("Date input"), value = "2014-01-01"),  
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("dateOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/071-widget-date/")
      )),
    
    column(4,
      wellPanel(
        dateRangeInput("dates", label = h3("Date range")),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("datesOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/072-widget-date-range/")
      )),
    
    column(4,
      wellPanel(
        fileInput("file", label = h3("File input")),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("fileOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/073-widget-file/")
      ))
  ),
  
  fluidRow(
        
    column(4,
      wellPanel(
        numericInput("num", label = h3("Numeric input"), value = 1),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("numOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/074-widget-numeric/")
      )),
    
    column(4,
      wellPanel(
        radioButtons("radio", label = h3("Radio buttons"),
          choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
          selected = 1),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("radioOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/075-widget-radio/")
      )),
    
    column(4,
      wellPanel(
        selectInput("select", label = h3("Select box"), 
        choices = list("Choice 1" = 1, "Choice 2" = 2,
                       "Choice 3" = 3), selected = 1),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("selectOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/076-widget-select/")
      ))
  ),
  
  fluidRow(
    
    column(4,
      wellPanel(
        sliderInput("slider1", label = h3("Slider"), min = 0, max = 100, 
                    value = 50),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("slider1Out"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/077-widget-slider/")
      )),
    
    column(4,
      wellPanel(
        sliderInput("slider2", label = h3("Slider range"), min = 0, 
                    max = 100, value = c(25, 75)),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("slider2Out"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/077-widget-slider/")
      )),
    
    column(4,
      wellPanel(
        textInput("text", label = h3("Text input"), 
                  value = "Enter text..."),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("textOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/080-widget-text/")
    )) 
  )

)
