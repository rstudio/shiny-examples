The `renderImage()` and `imageOutput()` functions can be used to display any image files on the client. This is in contrast to the `renderPlot()` and `plotOutput()` functions, which are used for images created by R's usual plot rendering device.

In the upper image, `image1`, a new image file is created each time the slider changes, and the `deleteFile=TRUE` argument tells the server to delete the temporary iamge file after it's sent to the client. 

This technique can be also used for pre-rendered images. The lower image, `image2` sends pre-rendered images to the client. In this case the `deleteFile=FALSE` argument is used so that the image files aren't deleted after being sent to the client.
