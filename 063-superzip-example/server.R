library(shiny)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)

# Leaflet bindings are a bit slow; for now we'll just sample to compensate
set.seed(100)
zipdata <- allzips[sample.int(nrow(allzips), 10000),]
# By ordering by centile, we ensure that the (comparatively rare) SuperZIPs
# will be drawn last and thus be easier to see
zipdata <- zipdata[order(zipdata$centile),]

shinyServer(function(input, output, session) {
  
  ## Interactive Map ###########################################

  # Create the map
  map <- createLeafletMap(session, "map")

  # A reactive expression that returns the set of zips that are
  # in bounds right now
  zipsInBounds <- reactive({
    if (is.null(input$map_bounds))
      return(zipdata[FALSE,])
    bounds <- input$map_bounds
    latRng <- range(bounds$north, bounds$south)
    lngRng <- range(bounds$east, bounds$west)
    
    subset(zipdata,
      latitude >= latRng[1] & latitude <= latRng[2] &
        longitude >= lngRng[1] & longitude <= lngRng[2])
  })
  
  # Precalculate the breaks we'll need for the two histograms
  centileBreaks <- hist(plot = FALSE, allzips$centile, breaks = 20)$breaks

  output$histCentile <- renderPlot({
    # If no zipcodes are in view, don't plot
    if (nrow(zipsInBounds()) == 0)
      return(NULL)
    
    hist(zipsInBounds()$centile,
      breaks = centileBreaks,
      main = "SuperZIP score (visible zips)",
      xlab = "Percentile",
      xlim = range(allzips$centile),
      col = '#00DD00',
      border = 'white')
  })
  
  output$scatterCollegeIncome <- renderPlot({
    # If no zipcodes are in view, don't plot
    if (nrow(zipsInBounds()) == 0)
      return(NULL)
    
    print(xyplot(income ~ college, data = zipsInBounds(), xlim = range(allzips$college), ylim = range(allzips$income)))
  })
  
  # session$onFlushed is necessary to work around a bug in the Shiny/Leaflet
  # integration; without it, the addCircle commands arrive in the browser
  # before the map is created.
  session$onFlushed(once=TRUE, function() {
    paintObs <- observe({
      colorBy <- input$color
      sizeBy <- input$size

      colorData <- if (colorBy == "superzip") {
        as.numeric(allzips$centile > (100 - input$threshold))
      } else {
        allzips[[colorBy]]
      }
      colors <- brewer.pal(7, "Spectral")[cut(colorData, 7, labels = FALSE)]
      colors <- colors[match(zipdata$zipcode, allzips$zipcode)]
      
      # Clear existing circles before drawing
      map$clearShapes()
      # Draw in batches of 1000; makes the app feel a bit more responsive
      chunksize <- 1000
      for (from in seq.int(1, nrow(zipdata), chunksize)) {
        to <- min(nrow(zipdata), from + chunksize)
        zipchunk <- zipdata[from:to,]
        # Bug in Shiny causes this to error out when user closes browser
        # before we get here
        try(
          map$addCircle(
            zipchunk$latitude, zipchunk$longitude,
            (zipchunk[[sizeBy]] / max(allzips[[sizeBy]])) * 30000,
            zipchunk$zipcode,
            list(stroke=FALSE, fill=TRUE, fillOpacity=0.4),
            list(color = colors[from:to])
          )
        )
      }
    })
    
    # TIL this is necessary in order to prevent the observer from
    # attempting to write to the websocket after the session is gone.
    session$onSessionEnded(paintObs$suspend)
  })
  
  # Show a popup at the given location
  showZipcodePopup <- function(zipcode, lat, lng) {
    selectedZip <- allzips[allzips$zipcode == zipcode,]
    content <- as.character(tagList(
      tags$h4("Score:", as.integer(selectedZip$centile)),
      tags$strong(HTML(sprintf("%s, %s %s",
        selectedZip$city.x, selectedZip$state.x, selectedZip$zipcode
      ))), tags$br(),
      sprintf("Median household income: %s", dollar(selectedZip$income * 1000)), tags$br(),
      sprintf("Percent of adults with BA: %s%%", as.integer(selectedZip$college)), tags$br(),
      sprintf("Adult population: %s", selectedZip$adultpop)
    ))
    map$showPopup(lat, lng, content, zipcode)
  }

  # When map is clicked, show a popup with city info
  clickObs <- observe({
    map$clearPopups()
    event <- input$map_shape_click
    if (is.null(event))
      return()
    
    isolate({
      showZipcodePopup(event$id, event$lat, event$lng)
    })
  })
  
  session$onSessionEnded(clickObs$suspend)
  
  
  ## Data Explorer ###########################################
  
  observe({
    cities <- if (is.null(input$states)) character(0) else {
      filter(cleantable, State %in% input$states) %.%
        `$`('City') %.%
        unique() %.%
        sort()
    }
    stillSelected <- isolate(input$cities[input$cities %in% cities])
    updateSelectInput(session, "cities", choices = cities,
      selected = stillSelected)
  })
  
  observe({
    zipcodes <- if (is.null(input$states)) character(0) else {
      cleantable %.%
        filter(State %in% input$states,
          is.null(input$cities) | City %in% input$cities) %.%
        `$`('Zipcode') %.%
        unique() %.%
        sort()
    }
    stillSelected <- isolate(input$zipcodes[input$zipcodes %in% zipcodes])
    updateSelectInput(session, "zipcodes", choices = zipcodes,
      selected = stillSelected)
  })
  
  observe({
    if (is.null(input$goto))
      return()
    isolate({
      map$clearPopups()
      dist <- 0.5
      zip <- input$goto$zip
      lat <- input$goto$lat
      lng <- input$goto$lng
      showZipcodePopup(zip, lat, lng)
      map$fitBounds(lat - dist, lng - dist,
        lat + dist, lng + dist)
    })
  })
  
  output$ziptable <- renderDataTable({
    cleantable %.%
      filter(
        Score >= input$minScore,
        Score <= input$maxScore,
        is.null(input$states) | State %in% input$states,
        is.null(input$cities) | City %in% input$cities,
        is.null(input$zipcodes) | Zipcode %in% input$zipcodes
      ) %.%
      mutate(Action = paste('<a class="go-map" href="" data-lat="', Lat, '" data-long="', Long, '" data-zip="', Zipcode, '"><i class="fa fa-crosshairs"></i></a>', sep=""))
  })
})
