
    dateRangeInput(inputId, label, start = NULL, end = NULL, min = NULL, max = NULL, format = "yyyy-mm-dd", startview = "month", weekstart = 0, language = "en", separator = " to ")
    
Creates two text fields that the user can click on to access calendars to select a date range. Sends the result to the server as a vector with two `Date` objects.

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the text fields

`start` 
The start date to display. Either a Date object, or a string in yyyy-mm-dd format. If NULL (the default), will use the current date in the client's time zone.

`end` 
The end date to display. Either a Date object, or a string in yyyy-mm-dd format. If NULL (the default), will use the current date in the client's time zone.

`separator`
The string to display between the start and end boxes

`min`
The minimum allowed date. Either a Date object, or a string in yyyy-mm-dd format.

`max`
The maximum allowed date. Either a Date object, or a string in yyyy-mm-dd format.

`format`
The format of the date to display in the browser. Defaults to "yyyy-mm-dd". See the help page for a list of options (`?dateInput`).

`startview`
The date range shown when a text field is first clicked. Can be "month" (the default), "year", or "decade".

`weekstart`
Which day is the start of the week. Should be an integer from 0 (Sunday) to 6 (Saturday).

`language`
The language used for month and day names. Default is "en" for English. Other valid values include "bg", "ca", "cs", "da", "de", "el", "es", "fi", "fr", "he", "hr", "hu", "id", "is", "it", "ja", "kr", "lt", "lv", "ms", "nb", "nl", "pl", "pt", "pt-BR", "ro", "rs", "rs-latin", "ru", "sk", "sl", "sv", "sw", "th", "tr", "uk", "zh-CN", and "zh-TW".

_Make this widget by copying the code in ui.R._
