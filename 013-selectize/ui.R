library(shiny)

states <- setNames(state.abb, state.name)
shinyUI(fluidPage(
  titlePanel('Selectize examples'),
  sidebarLayout(sidebarPanel(
    selectInput('e0', '0. An ordinary select input', choices = states, selectize = FALSE),
    selectInput('e1', '1. A basic example (zero-configuration)', choices = states),
    selectInput('e2', '2. Multi-select', choices = states, multiple = TRUE),
    selectInput('e3', '3. Item creation', choices = states, options = list(create = TRUE)),
    selectInput(
      'e4', '4. Max number of options to show', choices = states,
      options = list(maxOptions = 5)
    ),
    selectInput(
      'e5', '5. Max number of items to select', choices = states, multiple = TRUE,
      options = list(maxItems = 2)
    )),
  mainPanel(
    selectInput('e6', '6. Select a movie', choices = '', options = list(
      theme = 'movies',
      valueField = 'title',
      labelField = 'title',
      searchField = 'title',
      options = list(),
      create = FALSE,
      render = I("{
  option: function(item, escape) {
    var actors = [];
    for (var i = 0, n = item.abridged_cast.length; i < n; i++) {
      actors.push('<span>' + escape(item.abridged_cast[i].name) + '</span>');
    }
    return '<div>' + '<img src=\"' + escape(item.posters.thumbnail) + '\" alt=\"\">' +
           '<span class=\"title\">' +
           '<span class=\"name\">' + escape(item.title) + '</span>' +
           '</span>' +
           '<span class=\"description\">' + escape(item.synopsis || 'No synopsis available at this time.') + '</span>' +
           '<span class=\"actors\">' + (actors.length ? 'Starring ' + actors.join(', ') : 'Actors unavailable') + '</span>' +
           '</div>';
  }
}"),
      load = I("function(query, callback) {
  if (!query.length) return callback();
  $.ajax({
    url: 'http://api.rottentomatoes.com/api/public/v1.0/movies.json',
    type: 'GET',
    dataType: 'jsonp',
    data: {
      q: query,
      page_limit: 10,
      apikey: '3qqmdwbuswut94jv4eua3j85'
    },
    error: function() {
      callback();
    },
    success: function(res) {
      callback(res.movies);
    }
  });
}")
    )),
    verbatimTextOutput('e4out')
  )
)))
