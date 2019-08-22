var timeout = 250;
var do_fns = function(arr, callback) {
  var fns = [].concat(arr);

  var try_exec = function() {
    if (fns.length == 0) {
      callback(null, true);
      return;
    }
    var fn = fns.shift(); // first element

    fn(function() {
      $(progress).text($(progress).text() + ".")
      setTimeout(try_exec, timeout);
    });
  }

  try_exec();
}



$(function() {

  var tabset_id = $("#tabs").attr("data-tabsetid");






  var tab_id = function(i) {
    return "#tab-" + tabset_id + "-" + i;
  }


  var counter = 0;
  var fns = [
    // init working tabs
    function(done) { $("#add").click(); done(); },
    function(done) { $("#add").click(); done(); },
    function(done) { $("#add").click(); done(); },

    // click tabs to cause error state
    function(done) {
      var clicks = $("#tabs a").get().map(function(el) {
        return function(done) {
          $(el).click();
          done();
        };
      });
      do_fns(clicks, done);
    },

    // add broken tabs
    function(done) { $("#add").click(); done(); },
    function(done) { $("#add").click(); done(); },
    function(done) { $("#add").click(); done(); },
    function(done) { $("#add").click(); done(); },

    // calculate value of active tab to get sum to check if working
    function(done) {

      var clicks = $("#tabs a").get().map(function(el) {
        return function(done) {
          var checks = [
            function(done) {
              $(el).click();
              done();
            },
            function(done) {
              // get number from active pane.
              var val = $(".tab-pane.active .val").text() - 0;
              counter = counter + val;
              done();
            }
          ];
          do_fns(checks, done)
        };
      });
      do_fns(clicks, done);
    },

    function(done) {
      var sum = 0;
      for (var i = 0; i < $(".tab-pane").get().length; i++) {
        sum += i;
      }

      if (counter == sum ) {
        $("#result").css("background-color", "#7be092").text("PASSED!")
      } else {
        $("#result").css("background-color", "#e07b7b").text("FAILED!\nCounted a sum of " + counter + " vs " + sum)
      }
    }
  ];


  do_fns(fns);


});
