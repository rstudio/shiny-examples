Sometimes it's useful to send messages from the server to the client, in a way that can't easily be handled with the usual Shiny output bindings.

`sendCustomMessage()` sends information from the server to the client. It's typically used inside an `observe()` statement. The message is converted from an R data structure to JSON using `RJSONIO::toJSON()`.

On the client side, a message handler function must be registered to receive and do something with the message. Here, the Javascript file (in the www/ directory) which registers the handler gets included in the head of the HTML page. (Make sure to look at the full source code to see the Javascript file.)

In this example, the message handler simply pops up an alert box which displays the content of the message.
