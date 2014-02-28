library(shiny)

states <- setNames(state.abb, state.name)
shinyUI(fluidPage(
  titlePanel('Selectize examples'),
  sidebarLayout(sidebarPanel(
    selectInput('e0', '0. An ordinary select input', choices = states, selectize = FALSE),
    selectizeInput('e1', '1. A basic example (zero-configuration)', choices = states),
    selectizeInput('e2', '2. Multi-select', choices = states, multiple = TRUE),
    selectizeInput('e3', '3. Item creation', choices = states, options = list(create = TRUE)),
    selectizeInput(
      'e4', '4. Max number of options to show', choices = states,
      options = list(maxOptions = 5)
    ),
    selectizeInput(
      'e5', '5. Max number of items to select', choices = states, multiple = TRUE,
      options = list(maxItems = 2)
    ),
    selectizeInput(
      'e6', '6. Placeholder', choices = states,
      options = list(
        placeholder = 'Please select an option below',
        onInitialize = I('function() { this.setValue(""); }')
      )
    )
  ),
  mainPanel(
    # use Github instead
    selectizeInput('github', 'Select a Github repo', choices = '', options = list(
      valueField = 'url',
      labelField = 'name',
      searchField = 'name',
      options = list(),
      create = FALSE,
      render = I("{
  option: function(item, escape) {
    return '<div>' +
           '<strong><img src=\"http://brianreavis.github.io/selectize.js/images/repo-' + (item.fork ? 'forked' : 'source') + '.png\" width=20 />' + escape(item.name) + '</strong>:' +
           ' <em>' + escape(item.description) + '</em>' +
           ' (by ' + escape(item.username) + ')' +
        '<ul>' +
            (item.language ? '<li>' + escape(item.language) + '</li>' : '') +
            '<li><span>' + escape(item.watchers) + '</span> watchers</li>' +
            '<li><span>' + escape(item.forks) + '</span> forks</li>' +
        '</ul>' +
    '</div>';
  }
}"),
      score = I("function(search) {
  var score = this.getScoreFunction(search);
  return function(item) {
    return score(item) * (1 + Math.min(item.watchers / 100, 1));
  };
}"),
      load = I("function(query, callback) {
  if (!query.length) return callback();
  $.ajax({
    url: 'https://api.github.com/legacy/repos/search/' + encodeURIComponent(query),
    type: 'GET',
    error: function() {
      callback();
    },
    success: function(res) {
      callback(res.repositories.slice(0, 10));
    }
  });
}")
    )),
    helpText('If the above searching fails, it is probably the Github API limit
             has been reached (5 per minute). You can try later.'),
    verbatimTextOutput('e4out')
  )
)))
