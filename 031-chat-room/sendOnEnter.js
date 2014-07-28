// This script just listens for "enter"s on the text input and simulates
// clicking the "send" button when that occurs. Totally optional.
jQuery(document).ready(function(){
  jQuery('#entry').keypress(function(evt){
    if (evt.keyCode == 13){
      // Enter, simulate clicking send
      jQuery('#send').click();
    }
  });
})

// We don't yet have an API to know when an element is updated, so we'll poll
// and if we find the content has changed, we'll scroll down to show the new
// comments.
var oldContent = null;
window.setInterval(function() {
  var elem = document.getElementById('chat');
  if (oldContent != elem.innerHTML){
    scrollToBottom();
  }
  oldContent = elem.innerHTML;  
}, 300);

// Scroll to the bottom of the chat window.
function scrollToBottom(){
  var elem = document.getElementById('chat');
  elem.scrollTop = elem.scrollHeight;
}