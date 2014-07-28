
    checkboxGroupInput(inputId, label, choices, selected = NULL)
    
Creates a group of checkboxes. The widget sends the server a character vector that contains the values of the selected boxes.

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the check boxes

`choices` 
A list of values. The widget will build a checkbox for each value of the list. If the list has names, these will be displayed next to the checkboxes. Otherwise the values themselves will be displayed. 

`selected`
The values that should initially be selected, if any.

_Make this widget by copying the code in ui.R._
