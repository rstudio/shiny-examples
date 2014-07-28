
    fileInput(inputId, label, multiple = FALSE, accept = NULL)
    
Creates a file upload manager that can be used to upload one or more files at once. **Does not work on older browsers, including Internet Explorer 9 and earlier.** 

The file upload widget will pass the server a data frame that contains one row for each file uploaded and four columns:

* `name` The filename provided by the web browser for the file
* `size` The size of the uploaded file in bytes
* `type` The MIME type of the file (as reported by the browser). For example `text/plain` or an empty string (if the browser could not determine the type).
* `datapath` The path to the temp file that contains the data that was uploaded. This file may be deleted if the user performs another upload operation.

##### Arguments

`inputId` 
The name to use to look up the value of the widget (as a character string)

`label` 
A label to display above the widget

`multiple` 
Whether or not the user should be allowed to upload multiple files at once

`accept` 
A character vector of MIME types that the browser can expect the uploaded files to be.

_Make this widget by copying the code in ui.R._
