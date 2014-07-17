We can use `updateSelectizeInput(server = TRUE)` to make use of the server-side selectize input, but it is not straightforward to obtain the `<optgroup>` info from the server side dynamically. In this case, we just predefine the option groups in the initialization configurations.

Note this feature requires **shiny** >= 0.10.1.
