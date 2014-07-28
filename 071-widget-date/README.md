
    dateInput(inputId, label, value = NULL, min = NULL, max = NULL, format = "yyyy-mm-dd", startview = "month", weekstart = 0, language = "en")
    
Creates a text field that the user can click on to access a calendar to select a date. Sends the result to the server as a date-time of class `Date`.

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the text field

`value` 
The initial date to display. Either a Date object, or a string in yyyy-mm-dd format. If NULL (the default), will use the current date in the client's time zone.

`min`
The minimum allowed date. Either a Date object, or a string in yyyy-mm-dd format.

`max`
The maximum allowed date. Either a Date object, or a string in yyyy-mm-dd format.

`format`
The format of the date to display in the browser. Defaults to "yyyy-mm-dd". See the help page for a list of options (`?dateInput`).

`startview`
The date range shown when the input object is first clicked. Can be "month" (the default), "year", or "decade".

`weekstart`
Which day is the start of the week. Should be an integer from 0 (Sunday) to 6 (Saturday).

`language`
The language used for month and day names. Default is "en" for English. Other valid values include "bg", "ca", "cs", "da", "de", "el", "es", "fi", "fr", "he", "hr", "hu", "id", "is", "it", "ja", "kr", "lt", "lv", "ms", "nb", "nl", "pl", "pt", "pt-BR", "ro", "rs", "rs-latin", "ru", "sk", "sl", "sv", "sw", "th", "tr", "uk", "zh-CN", and "zh-TW".

_Make this widget by copying the code in ui.R._
