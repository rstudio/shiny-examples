fluidPage(
  selectizeInput('group', NULL, NULL, multiple = TRUE, options = list(

    placeholder = 'Select a category',

    # predefine all option groups
    optgroups = list(
      list(value = '1st', label = 'First Class'),
      list(value = '2nd', label = 'Second Class'),
      list(value = '3rd', label = 'Third Class'),
      list(value = 'Crew', label = 'Crew')
    ),

    # 'Class' is a field in Titanic2 created in server.R
    optgroupField = 'Class',

    optgroupOrder = c('1st', '2nd', '3rd', 'Crew'),

    # you can type and search in these fields in Titanic2
    searchField = c('Sex', 'Age', 'Survived'),

    # how to render the options (each item is a row in Titanic2)
    render = I("{
      option: function(item, escape) {
        return '<div>' + escape(item.Age) + ' (' +
                (item.Sex == 'Male' ? '&male;' : '&female;') + ', ' +
                (item.Survived == 'Yes' ? '&hearts;' : '&odash;') + ')' +
               '</div>';
      }
    }")
  )),

  verbatimTextOutput('row'),
  title = 'Using options groups for server-side selectize input'
)
