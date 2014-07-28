// This recieves messages of type "testmessage" from the server.
Shiny.addCustomMessageHandler("testmessage",
  function(message) {
    alert(JSON.stringify(message));
  }
);
