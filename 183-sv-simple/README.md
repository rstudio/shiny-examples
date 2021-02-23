## Simple example of validation with shinyvalidate

Demonstrates simple usage of `InputValidator`.

The `iv$enable()` method is called at the top level, so validation feedback is displayed immediately upon starting the session.

The `output$valid` output displays the overall success/failure of validation, using `iv$is_valid()`.
