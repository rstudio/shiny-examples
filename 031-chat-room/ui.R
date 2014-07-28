library(shiny)

shinyUI(
  bootstrapPage(
    # We'll add some custom CSS styling -- totally optional
    includeCSS("shinychat.css"),
    
    # And custom JavaScript -- just to send a message when a user hits "enter"
    # and automatically scroll the chat window for us. Totally optional.
    includeScript("sendOnEnter.js"),
    
    div(
      # Setup custom Bootstrap elements here to define a new layout
      class = "container-fluid", 
      div(class = "row-fluid",
          # Set the page title
          tags$head(tags$title("ShinyChat")),
          
          # Create the header
          div(class="span6", style="padding: 10px 0px;",
              h1("ShinyChat"), 
              h4("Hipper than IRC...")
          ), div(class="span6", id="play-nice",
            "IP Addresses are logged... be a decent human being."
          )
          
      ),
      # The main panel
      div(
        class = "row-fluid", 
        mainPanel(
          # Create a spot for a dynamic UI containing the chat contents.
          uiOutput("chat"),
          
          # Create the bottom bar to allow users to chat.
          fluidRow(
            div(class="span10",
              textInput("entry", "")
            ),
            div(class="span2 center",
                actionButton("send", "Send")
            )
          )
        ),
        # The right sidebar
        sidebarPanel(
          # Let the user define his/her own ID
          textInput("user", "Your User ID:", value=""),
          tags$hr(),
          h5("Connected Users"),
          # Create a spot for a dynamic UI containing the list of users.
          uiOutput("userList"),
          tags$hr(),
          helpText(HTML("<p>Built using R & <a href = \"http://rstudio.com/shiny/\">Shiny</a>.<p>Source code available <a href =\"https://github.com/trestletech/ShinyChat\">on GitHub</a>."))
        )
      )
    )
  )
)
