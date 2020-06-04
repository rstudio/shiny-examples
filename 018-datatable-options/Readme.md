We can customize DataTables through the `options` argument of
`DT::datatable()`. Below is a brief explanation of the examples
above:

1. the option `pageLength = 25` changes the default number of rows to
  display from 10 to 25;

1. the option `lengthMenu = list(c(5, 15, -1), c('5', '15', 'All'))` sets
  the length menu items (in the top left corner); it can be either a numeric
  vector (e.g. `c(5, 10, 30, 100)`), or a list of length 2 -- in the latter
  case, the first element is the length options, and the second element
  contains their labels to be shown in the menu;

1. `paging = FALSE` disables pagination, i.e. all records in the data are
  shown at once; alternatively, you can set `pageLength = -1`;

1. `searching = FALSE` disables searching, and no searching boxes will be shown;

1. any character strings wrapped in `JS()` will be treated as literal JavaScript
  code, and evaluated using `eval()` in JavaScript, so we can pass, for
  example, JS functions to DataTables;
