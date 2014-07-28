library(shiny)
library(ggplot2)

# Get the current day of the month
dom <- 25

# Define the target for salespeople in our organization.
salesTarget <- 15000

# Set the seed so we always get the same data.
set.seed(1000)

# Generate some random sales data for the sake of demonstration.
salesData <- data.frame(
  salesperson = c(rep("sales1", dom+1), rep("sales2", dom+1)),
  day = rep(0:dom, 2),
  dailySales = round(runif((dom+1)*2, 0, 1000),2)
)
# Zero out the start of the month (day 0)
salesData[salesData$day == 0,"dailySales"] <- 0

# Compute the running total of all sales for each salesperson through the month.
salesData$salesTotal <- ave(salesData$dailySales, 
                            salesData$salesperson, 
                            FUN = cumsum)

shinyServer(function(input, output, session) {   

  # This reactive may be simple enough to be unneccessary in production. But
  # it can be useful for development and testing to be able to plug in a user
  # name here to see how the application behaves.
  user <- reactive({
    session$user
  })
  
  # Based on the logged in user, pull out only the data this user should be able
  # to see.
  myData <- reactive({
    if (isManager()){
      # If a manager, show everything.
      return(salesData)
    } else{
      # If a regular salesperson, only show their own sales.
      return(salesData[salesData$salesperson == user(),])
    }
  })
  
  # Determine whether or not the user is a manager.
  isManager <- reactive({
    if (user() == "manager"){
      return(TRUE)
    } else{
      return(FALSE)
    }
  })
  
  # Render the subtitle of the page according to what user is logged in.
  output$subtitle <- renderText({
    if (is.null(user())){
      return("You must log in to use this application using Shiny Server Pro.")
    }
    
    if (isManager()){
       return("Monthly Manager Sales Report")
     } else {
       return(paste0("Monthly Sales Report for '", user(), "'"))
     }
  })
  
  output$salesPlot <- renderPlot({
    # If no user is logged in, render a blank plot.
    if (is.null(user())){
      return()
    }
    
    # Get all data that should be visible to the current user.
    data <- myData() 
    
    # Generate the sales plot
    p <- ggplot(data, aes(day, salesTotal, group=salesperson, color=salesperson))
    p <- p + geom_point()
    p <- p + geom_hline(yintercept=salesTarget, color=7)    
    p <- p + xlim(0, 30)
    p <- p + stat_smooth(method="lm", fullrange=TRUE)
    p <- p + ggtitle("September Sales Projections")
    p <- p + xlab("Day of Month")
    p <- p + ylab("Total Sales (USD)")
    print(p)    
  })
  
  output$salesTbl <- renderDataTable({
    # If no user is logged in, don't show any data.
    if (is.null(user())){
      return()
    }
    
    # Otherwise return all data that should be visible to this user.
    myData()
  })
})
