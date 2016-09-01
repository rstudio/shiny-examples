When a `submitButton` is present in a Shiny application, it causes **all** the inputs on the page to not send updates to the server until the button is pressed.

Because a `submitButton` alters the behavior of all other inputs on the page, we generally recommend **not** using `submitButton`, and using `actionButton` instead. In most cases, it is best not to use `submitButton`, but instead to use `actionButton`, since it allows finer-grained control over which inputs will trigger re-execution of code. See the `actionButton` demo in the gallery for more information.
