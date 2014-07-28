In this example, changing `n` will not result in an update to the summary text, because it is always used within `isolate()` on the server side.

However, changing `text` or clicking on the button will result in the summary text updating, because when `input$text` and `input$goButton` are accessed it is **not** inside `isolate()`.
