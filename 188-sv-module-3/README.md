# Passing validation rule to Shiny module

In this example, the `password_input` module server function allows the caller to customize the module's validation logic by providing a `password_rule` argument.

In this case, the customize rule enforces the presence of a number and upper-case letter, as well as a minimum password length of 8.