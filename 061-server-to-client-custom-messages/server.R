function(input, output, session) {
  # An observer is used to send messages to the client.
  # The message is converted to JSON
  observe({
    session$sendCustomMessage(type = 'testmessage',
      message = list(a = 1, b = 'text',
                     controller = input$controller))
  })
}
