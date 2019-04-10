(function() {
  function SimpleTextInput(props) {
    return React.createElement('input', {
      value: props.value,
      onChange: function(e) {
        props.setValue(e.target.value);
      }
    });
  }
  reactR.reactShinyInput('.simple-text-input', 'shiny.examples', SimpleTextInput);
})();
