
    selectInput(inputId, label, choices, selected = NULL, multiple = FALSE, selectize = TRUE)

    
Creates a drop-down list that you can use to select one or more items. The widget will pass the value of the selected items to the server as a vector of character strings (usually of length one).

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the drop-down box

`choices` 
A list of values. The widget will include a menu option for each value of the list. If the list has names, these will be displayed in the drop down menu. Otherwise the values themselves will be displayed. 

`selected`
The value(s) that should initially be selected. Defaults to the first value, or no values if `multiple = TRUE`.

`multiple`
`TRUE` if the user is allowed to select multiple values at once. `FALSE` otherwise.

`selectize`
`TRUE` id Shiny should use **selectize.js** to build an enriched selection box. `FALSE` if Shiny should build a basic selection box.

_Make this widget by copying the code in ui.R._
