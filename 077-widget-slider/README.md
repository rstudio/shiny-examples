
    sliderInput(inputId, label, min, max, value, step = NULL, round = FALSE, format = "#,##0.#####", locale = "us", ticks = TRUE, animate = FALSE)

    
Creates a slider bar to select one **or two** values. Passes the selected values to the server as a number or a vector of two numbers.

*Note: A slider bar and a slider range both use the same function, `sliderInput`. See the `value` argument for an explanation.*

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the slider bar

`min` 
The minimum value to use in the slider bar. 

`min` 
The maximum value to use in the slider bar. 

`value`
The initial value to display in the slider bar. If `value` is a vector of two numbers, Shiny will place two sliders on the bar, which will let your user select the endpoints of a range. If `value` is a single number, Shiny will create a basic slider like the one shown above.

`step`
The increment to place between each selectable value on the slider bar.

`round`
`TRUE` to round every value to an integer. `FALSE` to perform no rounding. An integer to specify which digit to round to. Positive integers will round to digits left of the decimal place. Negative integers will round to digits right of the decimal place.

`sep`
Separator between thousands places in numbers.

`pre`
A prefix string to put in front of the value.

`post`
A suffix string to put after the value.

`ticks`
`TRUE` to show tick marks, `FALSE` to hide them.

`animate`
`TRUE` to show default animation controls with default settings. This will let your user "play" the app as it iterates through every slider value. `FALSE` otherwise.

_Make this widget by copying the code in ui.R._
