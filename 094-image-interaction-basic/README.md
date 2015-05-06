This app demonstrates basic interactions with a dynamically-generated PNG image, which has a grid of lines spaced by 10 pixels.

With `imageOutput`, Shiny provides pixel coordinates. This is in contrast to `plotOutput`, for which Shiny provides coordinates that are scaled to the data values.

Note that depending on your browser window's width, you may see non-integer values for `x` or `y`. This is because, although the mouse cursor always has an integer-valued position, the image itself may have a non-integer position. You can see the image position in most web browsers by opening the Javascript console and running `$('#image1').offset()`.
