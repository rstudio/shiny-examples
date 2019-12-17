library(shiny)
library(curl)
library(future)
plan(multisession)

async_status_code <- function(url, headers) {
  future({
    h <- new_handle()
    do.call(handle_setheaders, c(list(h), headers))
    curl_fetch_memory(url, handle = h)$status_code
  })
}

ui <- fluidPage(
  h2("Connection Header test"),
  p(
    "This tests whether static JS assets can be successfully served when",
    "the request contains a spurious", tags$code("Connection: upgrade"), "header.",
    "This is a common situation with slightly misconfigured NGINX proxies."
  ),
  p(
    tags$a(href = "https://github.com/rstudio/shiny/issues/2372", "Issue"),
    "|",
    tags$a(href = "https://github.com/rstudio/httpuv/pull/215", "PR"),
    "|",
    tags$a(href = "https://community.rstudio.com/t/having-problems-with-shiny-v1-3-0-and-nginx/28180",
      "Announcement"
    )
  ),
  hr(),
  p(
    tags$strong("Instructions:"),
    "Verify that both values below are", tags$samp("200")
  ),
  p(
    "Without header:",
    textOutput("without_connection_upgrade", container = tags$samp)
  ),
  p(
    "With header:",
    textOutput("with_connection_upgrade", container = tags$samp)
  )
)

server <- function(input, output, session) {
  
  url <- reactive({
    port <- session$request$SERVER_PORT
    if (port == "")
      port <- "80"
    sprintf("http://localhost:%s/shared/jquery.min.js", port)
  })
  
  output$without_connection_upgrade <- renderText({
    async_status_code(url(), list(
      Connection = "Upgrade",
      "Shiny-Shared-Secret" = getOption("shiny.sharedSecret", "")
    ))
  })

  output$with_connection_upgrade <- renderText({
    async_status_code(url(), list(
      "Shiny-Shared-Secret" = getOption("shiny.sharedSecret", "")
    ))
  })
}

shinyApp(ui, server)
