## Validation within Shiny module

This example demonstrates how `InputValidator` is used within a Shiny module. The module server function creates an `InputValidator` and populates it with rules, then returns it to the caller (the app server function in this case). The caller then calls `enable()`.
