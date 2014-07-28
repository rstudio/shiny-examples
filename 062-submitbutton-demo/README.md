When a `submitButton` is present in a Shiny application, it causes **all** the inputs on the page to not send updates to the server until the button is pressed.

In most cases, it is best not to use `submitButton`, but instead to use `actionButton`, since it allows finer-grained control over which inputs will trigger re-execution of code. See the `actionButton` demo in the gallery for more information.
