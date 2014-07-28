
    numericInput(inputId, label, value, min = NA, max = NA, step = NA)

    
Creates a box you can use to enter numeric values. You can type a number or scroll through values with the box's scroll bar. The widget will pass the value shown in the box to the server as a double (e.g. number).

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the number field

`value` 
The initial number to display in the number field

`min` 
The minimum number that can be selected

`max` 
The maximum number that can be selected

`step` 
The amount to increment the value by when a user clicks up or down on the scroll bar.

_Make this widget by copying the code in ui.R._
