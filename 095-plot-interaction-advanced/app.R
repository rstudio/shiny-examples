library(ggplot2)
library(Cairo)   # For nicer ggplot2 output when deployed on Linux
library(DT)

# A modified version of mtcars with some columns removed, some columns added,
# and some columns as factors.
mtc <- mtcars
mtc$cyl <- factor(mtc$cyl)
mtc$am  <- factor(mtc$am)
mtc$vs  <- NULL
mtc$disp <- NULL
mtc$hp <- NULL
mtc$qsec <- NULL
mtc$gear <- NULL
mtc$drat <- NULL
mtc$carb <- NULL

mtc$date <- Sys.Date() + seq_len(nrow(mtc))
mtc$datetime <- Sys.time() + 60 * seq_len(nrow(mtc))

# Data set with points on a grid
grid <- data.frame(
  x = rep(1:8, 4),
  xf = factor(rep(1:8, 4)),
  y = rep(1:4, each = 8),
  facet1 = factor(rep(1:2, 16)),
  facet2 = factor(rep(1:4, 8))
)

shinyApp(
  ui = fluidPage(
    # Some custom CSS
    tags$head(
      tags$style(HTML("
        /* Smaller font for preformatted text */
        pre, table.table {
          font-size: smaller;
        }

        body {
          min-height: 2000px;
        }

        .option-group {
          border: 1px solid #ccc;
          border-radius: 6px;
          padding: 0px 5px;
          margin: 5px -10px;
          background-color: #f5f5f5;
        }

        .option-header {
          color: #79d;
          text-transform: uppercase;
          margin-bottom: 5px;
        }
      "))
    ),


    fluidRow(
      column(width=3,
        div(class = "option-group",
          radioButtons("dataset", "Data set",
            choices = c("mtcars", "diamonds", "grid"), inline = TRUE),
          radioButtons("plot_type", "Plot type",
            c("base", "ggplot2"), inline = TRUE),

          conditionalPanel("input.plot_type === 'base'",
            selectInput("plot_scaletype", "Scale type",
              c("normal" = "normal",
                "log" = "log",
                "x factor" = "x_factor",
                "datetime" = "datetime"
              ),
              selectize = FALSE
            )
          ),
          conditionalPanel("input.plot_type === 'ggplot2'",
            selectInput("ggplot_scaletype", "Scale type",
              c("normal" = "normal",
                "reverse (scale_*_reverse())" = "reverse",
                "log10 (scale_*_log10())" = "log10",
                "log2 (scale_*_continuous( trans=log2_trans()))" = "log2",
                "log10 (coord_trans())" = "log10_trans",
                "log2 (coord_trans())" = "log2_trans",
                "coord_cartesian()" = "coord_cartesian",
                "coord_flip()" = "coord_flip",
                "coord_fixed()" = "coord_fixed",
                "coord_polar() (doesn't work)" = "coord_polar",
                "x factor" = "x_factor",
                "date and time" = "datetime"
              ),
              selectize = FALSE
            ),
            selectInput("ggplot_facet", "Facet",
              c("none" = "none",
                "wrap" = "wrap",
                "grid x" = "grid_x",
                "grid y" = "grid_y",
                "grid xy" = "grid_xy",
                "grid xy free" = "grid_xy_free"
              ),
              selectize = FALSE
            )
          )
        )
      ),
      column(width = 3,
        div(class = "option-group",
          div(class = "option-header", "Double-click"),
          sliderInput("dblclick_delay", "Delay", min=100, max=1000, value=400,
            step=100)
        ),
        div(class = "option-group",
          div(class = "option-header", "Hover"),
          radioButtons("hover_policy", "Input rate policy",
            c("debounce", "throttle"), inline = TRUE),
          sliderInput("hover_delay", "Delay", min=100, max=1000, value=200,
            step=100),
          checkboxInput("hover_null_outside", "NULL when outside", value=TRUE)
        )
      ),
      column(width = 3,
        div(class = "option-group",
          div(class = "option-header", "Brush"),
          radioButtons("brush_dir", "Direction(s)",
            c("xy", "x", "y"), inline = TRUE),
          radioButtons("brush_policy", "Input rate policy",
            c("debounce", "throttle"), inline = TRUE),
          sliderInput("brush_delay", "Delay", min=100, max=1000, value=200,
            step=100),
          checkboxInput("brush_reset", "Reset on new image")
        )
      ),
      column(width = 3,
        verbatimTextOutput("plot_dblclickinfo")
      )
    ),

    fluidRow(
      column(width = 6,
        uiOutput("plotui")
      ),
      column(width = 3,
        verbatimTextOutput("plot_clickinfo")
      ),
      column(width = 3,
        verbatimTextOutput("plot_hoverinfo")
      )
    ),
    fluidRow(
      column(width = 9,
        wellPanel(
          div(class = "option-group",
            div(class = "option-header", "nearPoints() options"),
            flowLayout(
              sliderInput("max_distance", "Max distance (pixels)",
                min=1, max=20, value=5, step=1),
              sliderInput("max_points", "Max number of rows to select",
                min=1, max=100, value=100, step=1)
            )
          ),
          h4("Points selected by clicking, with nearPoints():"),
          DT::dataTableOutput("plot_clicked_points")
        ),
        wellPanel(width = 9,
          h4("Points selected by brushing, with brushedPoints():"),
          DT::dataTableOutput("plot_brushed_points")
        )
      ),
      column(width = 3,
            verbatimTextOutput("plot_brushinfo")
      )
    )

  ),
  server = function(input, output, session) {

    # Currently selected dataset
    curdata <- reactive({
      switch(input$dataset, mtcars = mtc, diamonds = diamonds, grid = grid)
    })

    # Name of the x, y, and faceting variables
    xvar <- reactive({
      if ((input$plot_type == "base"    && input$plot_scaletype   == "x_factor") ||
          (input$plot_type == "ggplot2" && input$ggplot_scaletype == "x_factor"))
      {
        switch(input$dataset, mtcars = "cyl", diamonds = "cut", grid = "xf")

      } else if ((input$plot_type == "base"    && input$plot_scaletype   == "datetime") ||
                 (input$plot_type == "ggplot2" && input$ggplot_scaletype == "datetime")) {
        "datetime"
      } else {
        switch(input$dataset, mtcars = "wt", diamonds = "carat", grid = "x")
      }
    })

    yvar <- reactive({
      if ((input$plot_type == "base"    && input$plot_scaletype   == "datetime") ||
          (input$plot_type == "ggplot2" && input$ggplot_scaletype == "datetime")) {
        "date"
      } else {
        switch(input$dataset, mtcars = "mpg", diamonds = "price", grid = "y")
      }
    })

    facetvar1 <- reactive({
      if (input$plot_type != "ggplot2") return(NULL)
      if (input$ggplot_facet == "none") return(NULL)

      switch(input$dataset, mtcars = "cyl", diamonds = "cut", grid = "facet1")
    })

    facetvar2 <- reactive({
      if (input$plot_type != "ggplot2") return(NULL)
      if (input$ggplot_facet == "none") return(NULL)
      if (!(input$ggplot_facet %in% c("grid_xy", "grid_xy_free"))) return(NULL)

      switch(input$dataset, mtcars = "am", diamonds = "clarity", grid = "facet2")
    })


    output$plotui <- renderUI({
      plotOutput("plot", height=300,
        click = "plot_click",
        dblclick = dblclickOpts(
          id = "plot_dblclick",
          delay = input$dblclick_delay
        ),
        hover = hoverOpts(
          id = "plot_hover",
          delay = input$hover_delay,
          delayType = input$hover_policy,
          nullOutside = input$hover_null_outside
        ),
        brush = brushOpts(
          id = "plot_brush",
          delay = input$brush_delay,
          delayType = input$brush_policy,
          direction = input$brush_dir,
          resetOnNew = input$brush_reset
        )
      )
    })
    output$plot <- renderPlot({
      if (input$plot_type == "base") {
        xvals <- curdata()[[xvar()]]
        yvals <- curdata()[[yvar()]]

        # Reduce margins
        par(mar = c(4, 4, 0.5, 0.5))

        switch(input$plot_scaletype,
          normal = ,
          x_factor = ,
          datetime =
            plot(xvals, yvals),
          log =
            plot(xvals, yvals, log = "xy")
        )

      } else if (input$plot_type == "ggplot2") {
        dat <- curdata()
        pc <- ggplot(curdata(), aes_string(xvar(), yvar())) +
            geom_point() +
            theme_bw()

        p <- switch(input$ggplot_scaletype,
          normal =
            pc,
          reverse =
            pc + scale_x_reverse() + scale_y_reverse(),
          log10 =
            pc + scale_x_log10() + scale_y_log10(),
          log2 =
            pc + scale_x_continuous(trans = scales::log2_trans()) +
                 scale_y_continuous(trans = scales::log2_trans()),
          log10_trans =
            pc + coord_trans(x = "log10", y = "log10"),
          log2_trans =
            pc + coord_trans(x = "log2", y = "log2"),
          coord_cartesian =
            pc + coord_cartesian(xlim = c(2,4), ylim = c(0,50)),
          coord_flip =
            pc + coord_flip(),
          coord_fixed =
            pc + coord_fixed(),
          coord_polar =
            pc + coord_polar(),
          # Discrete x, continuous y
          x_factor =
            pc,
          # Datetime x, Date y
          datetime =
            pc
        )

        # Need to pass faceting specs as strings
        p <- switch(input$ggplot_facet,
          none =
            p,
          wrap = {
            # facet_wrap needs a formula object (bug: it can't take a string)
            facet_formula <- as.formula(paste("~", facetvar1()))
            p + facet_wrap(facet_formula, ncol = 2)
          },
          grid_x =
            p + facet_grid(paste(". ~", facetvar1())),
          grid_y =
            p + facet_grid(paste(facetvar1(), "~ .")),
          grid_xy =
            p + facet_grid(paste(facetvar2(), "~",  facetvar1())),
          grid_xy_free =
            p + facet_grid(paste(facetvar2(), "~",  facetvar1()), scales = "free")
        )

        p
      }
    })
    output$plot_clickinfo <- renderPrint({
      cat("input$plot_click:\n")
      str(input$plot_click)
    })
    output$plot_dblclickinfo <- renderPrint({
      cat("input$plot_dblclick:\n")
      str(input$plot_dblclick)
    })
    output$plot_hoverinfo <- renderPrint({
      cat("input$plot_hover:\n")
      str(input$plot_hover)
    })
    output$plot_brushinfo <- renderPrint({
      cat("input$plot_brush:\n")
      str(input$plot_brush)
    })
    output$plot_clicked_points <- DT::renderDataTable({
      dat <- curdata()

      # With base graphics, we need to explicitly tell it which variables were
      # used; with ggplot2, we don't.
      if (input$plot_type == "base") {
        res <- nearPoints(dat, input$plot_click, xvar(), yvar(),
          threshold = input$max_distance, maxpoints = input$max_points,
          addDist = TRUE)

      } else if (input$plot_type == "ggplot2") {
        res <- nearPoints(dat, input$plot_click,
          threshold = input$max_distance, maxpoints = input$max_points,
          addDist = TRUE)
      }

      res$dist_ <- round(res$dist_, 1)

      datatable(res)
    })
    output$plot_brushed_points <- DT::renderDataTable({
      dat <- curdata()
      # With base graphics, we need to explicitly tell it which variables were
      # used; with ggplot2, we don't.
      if (input$plot_type == "base")
        res <- brushedPoints(dat, input$plot_brush, xvar(), yvar())
      else if (input$plot_type == "ggplot2")
        res <- brushedPoints(dat, input$plot_brush)

      datatable(res)
    })
  }
)
