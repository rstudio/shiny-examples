$(function() {
  $("#swallow_wrapper").on('shiny:inputchanged', function(event) {
    event.preventDefault();
  });
  $(document).on({

    'shiny:connected': function(event) {
      $('form.well').fadeOut(3000).fadeIn(2000);
    },

    'shiny:disconnected': function(event) {
      alert('Disconnected! The web socket state is ' + event.socket.readyState);
    },

    'shiny:busy': function(event) {
      $('#busyModal').modal('show');
    },

    'shiny:idle': function(event) {
      $('#busyModal').modal('hide');
    },

    'shiny:inputchanged': function(event) {
      switch (event.name) {

        // modify the title value during the event
        case 'title':
          event.value += ' (title modified by the JS event based on input$title)';
          break;

        // cancel the event so this button does not update the color
        case 'color2':
          event.preventDefault();
          break;

        default:

      }
    },

    'shiny:message': function(event) {
      console.log('Received a message from Shiny');
      var msg = event.message;
      if (msg.hasOwnProperty('custom') && msg.custom.hasOwnProperty('special')) {
        console.log('This is a special message from Shiny:');
        console.log(msg.custom.special);
      } else if (msg.hasOwnProperty('custom') && msg.custom.hasOwnProperty('swallow_fail')) {
        alert(msg.custom.swallow_fail.msg);
      }
    },

    'shiny:bound': function(event) {
      console.log('An ' + event.bindingType + ' (' + event.binding.name + ') was bound to Shiny');
    },

    'shiny:updateinput': function(event) {
      console.log({
        'Input message': event.message,
        'To be applied to': event.target
      });
    },

    'shiny:value': function(event) {
      if (event.name === 'slider_info2') {
        event.value = 'My output was modified by the shiny:value event.';
      }
    },

    'shiny:error': function(event) {
      if (event.name === 'error_info') {
        event.error.message = 'A nice error occurred :)';
      }
    },

    'shiny:recalculating': function(event) {
      console.log('An output is being recalculated... ' + new Date());
    },

    'shiny:recalculated': function(event) {
      console.log('An output has been recalculated! ' + new Date());
    }

  });

  // when the slider input is bound, add a red border to it
  $('#bins').on('shiny:bound', function(event) {
    $(this).parent().css('border', 'dotted 2px red');
  });

  Shiny.addCustomMessageHandler('special', function(message) {
    //
  });
});
