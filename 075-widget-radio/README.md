
    radioButtons(inputId, label, choices, selected = NULL)

    
Creates a set of radio buttons, several buttons only one of which can be pressed at any time. The widget will return the value of the selected button to the server as a character string.

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the buttons

`choices` 
A list of values. The widget will build a button for each value of the list. If the list has names, these will be displayed next to the buttons. Otherwise the values themselves will be displayed. 

`selected`
The value that should initially be selected, defaults to the first value.

_Make this widget by copying the code in ui.R._
