$(function() {
  setTimeout(function() {
    Shiny.setInputValue("test_evt", 1, {priority: "event"});
    Shiny.setInputValue("test_evt", 1, {priority: "event"});
    Shiny.setInputValue("test_evt", 1, {priority: "event"});
    Shiny.setInputValue("test_evt", 1, {priority: "event"});
    Shiny.setInputValue("test_evt", 1, {priority: "event"});

    Shiny.setInputValue("test_val", 1, {priority: "immediate"});
    Shiny.setInputValue("test_val", 1, {priority: "deferred"});
    Shiny.setInputValue("test_val", 1, {priority: "immediate"});
    Shiny.setInputValue("test_val", 1);
    Shiny.setInputValue("test_val", 1);
  }, 1000);
});
