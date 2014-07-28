Shiny comes with several types of inputs out of the box. You may find time when it would be useful to implement your own input bindings.

In this example, we've created an input binding for inputs with `type=url` (which requires a modern browser). This input binding is based on Shiny's built-in textInputBinding. URL behave very similary to regular text inputs, so you won't see any new features over and above what a textInputBinding will do. Still, the code demonstrates what's needed for writing your own input bindings.

This example application has files other than server.R and ui.R. To see them, make sure to see the full source code.
