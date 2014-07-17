Sometimes it is more convenient to group all options into a few categories for the select/selectize input. To enable option groups, just use a nested list as the value of the `choices` argument of `selectInput()` / `selectizeInput()`. At least one of the child elements of the list must be of length >= 2, in other words, at least one option group should contain more than one option.

Note this feature requires **shiny** >= 0.10.1.
