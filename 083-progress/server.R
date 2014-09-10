shinyServer(function(input, output) {

  # This example uses the withProgress, which is a simple-to-use wrapper around
  # the progress API.
  output$plot <- renderPlot({
    input$goPlot

    withProgress(message = 'Making plot', value = 0.1, {

      # withProgress calls can be nested, in which case the nested text appears
      # below, and a second bar is shown.
      withProgress(message = 'Doing this thing', detail = "It's important",
                   value = 0.1, {
        Sys.sleep(0.25)
        for (i in 1:9) {
          incProgress(0.1)
          Sys.sleep(0.05)
        }
      })

      # Increment the top-level progress indicator
      incProgress(0.5)


      # When value=NULL, progress text is displayed, but not a progress bar
      withProgress(message = 'And this also', detail = "It's super critical", 
                   value = NULL, {

        Sys.sleep(1)
      })

      # We could also increment the progress indicator like so:
      # incProgress(0.5)
      # but it's also possible to set the progress bar value directly to a
      # specific value:
      setProgress(1)
    })


    plot(cars$speed, cars$dist)
  })


  # This example uses the Progress object API directly
  output$table <- renderTable({
    input$goTable

    # Create a Progress object
    progress <- shiny::Progress$new()

    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())

    Sys.sleep(0.25)
    progress$set(message = 'Computing table', value = 0.2)
    Sys.sleep(0.25)
    progress$set(detail = 'sampling rows...', value = 0.3)
    Sys.sleep(0.25)
    progress$set(value = 0.5)

    Sys.sleep(0.25)
    progress$set(value = 0.75)
    Sys.sleep(0.25)
    progress$set(value = 1)


    cars[sample(nrow(cars), 5), ]
  })

})
