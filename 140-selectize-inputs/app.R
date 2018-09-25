library(shiny)

bigvec <- paste0("a", 1:1e5)
named_bigvec <- setNames(bigvec, bigvec)
nested_biglist <- lapply(named_bigvec, function(item) setNames(list(item), item))

test_set <- list(
  "Unnamed vector" = list(value = c(1, 2)),
  "Named vector" = list(value = c(a = 1, B = 2)),
  "Partially named vector" = list(value = c(a = 1, B = 2, 3)),
  "Unnamed list" = list(value = c(1, 2)),
  "Named list" = list(value = list(a = 1, B = 2, c = 3)),
  "Partially named list" = list(value = list(a = 1, B = 2, 3)),
  "Nested list" = list(value = list(a = 1, B = list(B = 2), c = list(3)), groups = "grouped"),
  "Big unnamed vector (server-side only)" = list(value = bigvec),
  "Big named vector (server-side only)" = list(value = named_bigvec),
  "Big unnamed list (server-side only)" = list(value = as.list(bigvec)),
  "Big named list (server-side only)" = list(value = as.list(named_bigvec)),
  "Big nested list (server-side only)" = list(value = nested_biglist, groups = "grouped"),
  "Data frame (server-side only)" = list(value = data.frame(label = c("a", "B"), value = c(1, 2)))
)

is_server_only <- function(test_name) {
  grepl("server-side", test_name)
}


client_output_name <- function(i) paste0("client-", i, "-output")
client_select_name <- function(i) paste0("client-", i, "-select")
server_output_name <- function(i) paste0("server-", i, "-output")
server_select_name <- function(i) paste0("server-", i, "-select")


ui <- fluidPage(
  tags$head(tags$style("
  table, th, td {
    border: 1px solid lightgrey;
    padding: 10px;
  }
  table {
    margin-bottom: 300px;
  }
  ")),
  tags$h1("Selectize with many different types of input values"),
  tags$h4("Validate that only the selectize inputs that state they have groups, have groups"),
  tags$h4("Validate that the clientside (left) and serverside (right) selectize rows behave similarly"),
  tags$table(
    lapply(seq_along(test_set), function(i) {
      test_name <- names(test_set)[i]
      test_val <- test_set[[test_name]]

      group_txt <-
        if (identical(test_val$groups, "grouped"))
          " - HAS GROUPS!"
        else
          ""

      tags$tr(
        tags$td(tags$h5(test_name)),
        tags$td(
          if (is_server_only(test_name)) {
            "- -"
          } else {
            selectizeInput(client_select_name(i), paste0("Client side", group_txt), choices = NULL)
          }
        ),
        tags$td(
          if (is_server_only(test_name)) {
            "- -"
          } else {
            verbatimTextOutput(client_output_name(i))
          }
        ),
        tags$td(
          selectizeInput(server_select_name(i), paste0("Server side", group_txt), choices = NULL)
        ),
        tags$td(
          verbatimTextOutput(server_output_name(i))
        )
      )
    })
  )
)

server <- function(input, output, session) {

  lapply(seq_along(test_set), function(i) {
    test_name <- names(test_set)[i]

    if (!is_server_only(test_name)) {
      updateSelectizeInput(session,
        client_select_name(i),
        choices = test_set[[i]]$value, selected = NULL, server = FALSE
      )

      output[[client_output_name(i)]] <- renderPrint({
        input[[client_select_name(i)]]
      })
    }

    updateSelectizeInput(session,
      server_select_name(i),
      choices = test_set[[i]]$value, selected = NULL, server = TRUE
    )
    output[[server_output_name(i)]] <- renderPrint({
      input[[server_select_name(i)]]
    })
  })

}

shinyApp(ui, server)
