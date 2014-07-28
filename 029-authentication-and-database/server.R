
library(shiny)
library(dplyr)
library(lubridate)

# Load libraries and functions needed to create SQLite databases.
library(RSQLite)
library(RSQLite.extfuns)
saveSQLite <- function(data, name){
  path <- dplyr:::db_location(filename=paste0(name, ".sqlite"))
  if (!file.exists(path)) {
    message("Caching db at ", path)
    src <- src_sqlite(path, create = TRUE)
    copy_to(src, data, name, temporary = FALSE)
  } else {
    src <- src_sqlite(path)
  }
  return (src)
}

# Load/create some data and put it in SQLite. In practice, the data you want
# likely already exists in the databse, so you would just be reading the data
# in from the database, not uploading it from R.

# Load and upload flights data
library(hflights)
hflights_db <- tbl(hflights_sqlite(), "hflights")

# Create a user membership data.frame that maps user names to an airline 
# company.
membership <- data.frame(
  user = c("kim", "sam", "john", "kelly", "ben", "joe"),
  company = c("", "DL", "AA", "UA", "US", "DL"),
  role = c("manager", rep("user", 5)))
membership_db <- tbl(saveSQLite(membership, "membership"), "membership")

airlines <- data.frame(
  abbrev = c("AA", "DL", "UA", "US"),
  name = c("American Airlines", "Delta Air Lines", 
           "United Airlines", "US Airways")
)
airline_db <- tbl(saveSQLite(airlines, "airline"), "airline")


#' Get the full name of an airline given its abbreviation.
airlineName <- function(abbr){
  as.data.frame(select(filter(airline_db, abbrev == abbr), name))[1,1]
}

shinyServer(function(input, output, session) {
  
  #' Get the current user's username
  user <- reactive({
    
    curUser <- session$user
    
    # Not logged in. Shiny Server Pro should be configured to prevent this.
    if (is.null(curUser)){
      return(NULL)
    }
    
    # Look up the user in the database to load all the associated data.
    user <- as.data.frame(
      filter(membership_db, user==curUser)      
    )
    
    # No user in the database
    if (nrow(user) < 1){
      return(NULL)
    }
    
    user[1,]    
  })
  
  #' Determine whether or not the current user is a manager.
  isManager <- reactive({
    if (is.null(user())){
      return(FALSE)
    }
    
    role <- user()$role
    return(role == "manager")    
  })
  
  #' Get the company of which the current user is a member
  userCompany <- reactive({
    if (is.null(user())){
      return(NULL)
    }
    
    if (isManager()){
      # If the user is a manager, then they're allowed to select any company
      # they want and view its data.
      if (is.null(input$company)){
        return(as.data.frame(airline_db)$abbrev[1])
      }
      return(input$company)
    }
    
    # Otherwise this is just a regular, logged-in user. Look up what company
    # they're associated with and return that.
    user()$company
  })
  
  #' Get the data the current user has permissions to see
  #' @return a dplyr tbl
  companyData <- reactive({
    # Trim down to only relevant variables
    delays <- select(hflights_db, Month, DayofMonth, DepDelay, UniqueCarrier)
    
    # Trim down to only values that we have permissions to see
    comp <- userCompany()
    delays <- filter(delays, UniqueCarrier == comp)
    
    delays
  })
  
  #' Of the data a user is allowed to see, further refine it to only include the
  #' date range selected by the user.
  filteredData <- reactive({
    # Get current month and day
    curMonth <- month(now())
    curDay <- day(now())

    # Get the previous month and day based on the slider input
    prevMonth <- month(now()-days(input$days))
    prevDay <- day(now()-days(input$days))
    
    # Filter to only include the flights in between the selected dates.
    data <- filter(companyData(), 
           (Month > prevMonth | (Month == prevMonth & DayofMonth >= prevDay)) &
           (Month < curMonth | (Month == curMonth & DayofMonth <= curDay)))
    
    as.data.frame(data)
  })
  
  output$title <- renderText({
    if(is.null(user())){
      return("ERROR: This application is designed to be run in Shiny Server Pro and to require authentication.")
    }
    paste0("Airline Delays for ", airlineName(userCompany()))
  })
  
  output$userPanel <- renderUI({
    if (isManager()){
      # The management UI should have a drop-down that allows you to select a 
      # company.
      tagList(
        HTML(paste0("Logged in as <code>", user()$user, 
                    "</code> who is a <code>", user()$role ,"</code>.")),
        hr(),
        p("As a manager, you may select any company's data you wish to view."),
        selectInput("company", "", as.data.frame(airline_db)$abbrev)
      )
    } else{
      # It's just a regular user. Just tell them who they are.
      HTML(paste0("Logged in as <code>", user()$user, "</code> with <code>",
                  airlineName(userCompany()),"</code>."))
    }
  })
  
  #' Print a boxplot of the selected data.
  output$box <- renderPlot({    
    boxplot(
      lapply(
        split(filteredData(), as.factor(
          paste0(filteredData()$Month, "/", filteredData()$DayofMonth))), 
        function(dayData){ 
          dayData$DepDelay 
        }
      ), ylab = "Delay (minutes)"
    )
  })
   
})
