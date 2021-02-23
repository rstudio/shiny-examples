# Shiny module with self-contained validation logic

This example demonstrates the usage of `InputValidator` inside of a module. In this example, the validation is entirely self-contained, meaning that the inputs to be validated, the rules used to validate them, and the actions that need to guard against invalid inputs are all entirely contained within the module.

In this simple case, the caller of the module does not even need to be aware that validation is being used by the module; it is just an implementation detail of the module itself.
