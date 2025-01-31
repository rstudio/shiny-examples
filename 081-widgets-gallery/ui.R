library(bslib)

 
fluidPage(  
      
  theme = bs_bundle(  
    bslib::bs_theme(
      version = 5, 
      heading_font = "Open Sans", 
      `headings-font-weight` = 400,
      base_font = bslib::font_collection(
        bslib::font_google("Open Sans", wght = c(300, 400, 500, 600, 700, 800)),
        "var(--bs-font-sans-serif)"
      ), 
      code_font = bslib::font_collection(
        bslib::font_google("Source Code Pro"),
        "SFMono-Regular",
        "Menlo", 
        "Monaco",
        "Consolas",
        "Liberation Mono",
        "Courier New",  
        "monospace" 
      )  
    ),
    sass::sass_layer_file("theme.scss")
  ),
  
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
      div(class="p-5",
        h3("Action button"),
        actionButton("action", label = "Action"),
        p("GARRICK: please make the Action button Bootstrap 5's .btn-outline-dark button instead. Thank you!"),
        a("btn-outline-dark", class = "btn btn-outline-dark btn-md", href="#" ),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("actionOut"),
        a("See Code", class = "btn btn-primary btn-md", 
          href = "https://gallery.shinyapps.io/068-widget-action-button/")
      )),
    
    column(4,
      div(class="p-5",
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
      div(class="p-5",
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
      div(class="p-5",
        dateInput("date", label = h3("Date input"), value = "2014-01-01"),  
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("dateOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/071-widget-date/")
      )),
    
    column(4,
      div(class="p-5",
        dateRangeInput("dates", label = h3("Date range")),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("datesOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/072-widget-date-range/")
      )),
    
    column(4,
      div(class="p-5",
        fileInput("file", label = h3("File input")),
        p("GARRICK: Can this be changed to bootstrap's file input instead? Asking for a friend."),
        a(href="https://getbootstrap.com/docs/5.0/forms/form-control/#file-input", "See bootstrap's file input"),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("fileOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/073-widget-file/")
      ))
  ),
  
  fluidRow(
        
    column(4,
      div(class="p-5",
        numericInput("num", label = h3("Numeric input"), value = 1),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("numOut"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/074-widget-numeric/")
      )),
    
    column(4,
      div(class="p-5",
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
      div(class="p-5",  
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
      div(class="p-5",
        sliderInput("slider1", label = h3("Slider"), min = 0, max = 100, 
                    value = 50),
        hr(),
        p("Current Value:", style = "color:#888888;"), 
        verbatimTextOutput("slider1Out"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/077-widget-slider/")
      )),
    
    column(4,
      div(class="p-5",
        sliderInput("slider2", label = h3("Slider range"), min = 0, 
                    max = 100, value = c(25, 75)),
        hr(),
        p("Current Values:", style = "color:#888888;"), 
        verbatimTextOutput("slider2Out"),
        a("See Code", class = "btn btn-primary btn-md",  
          href = "https://gallery.shinyapps.io/077-widget-slider/")
      )),
    
    column(4,
      div(class="p-5",   
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
