function(input, output, session) {

  # Create a random name for the log file
  logfilename <- tempfile('logfile', fileext = '.txt')

  # ============================================================
  # This part of the code writes to the log file every second.
  # Writing to the file could be done by an external process.
  # In this example, we'll write to the file from inside the app.
  logwriter <- observe({
    # Invalidate this observer every second (1000 milliseconds)
    invalidateLater(1000, session)

    # Clear log file if more than 10 entries
    if (file.exists(logfilename) &&
        length(readLines(logfilename)) > 10) {
      unlink(logfilename)
    }

    # Add an entry to the log file
    cat(as.character(Sys.time()), '\n', file = logfilename,
        append = TRUE)
  })

  # When the client ends the session, suspend the observer and
  # remove the log file.
  session$onSessionEnded(function() {
    logwriter$suspend()
    unlink(logfilename)
  })

  # ============================================================
  # This part of the code monitors the file for changes once per
  # 0.5 second (500 milliseconds).
  fileReaderData <- reactiveFileReader(500, session,
                                       logfilename, readLines)

  output$fileReaderText <- renderText({
    # Read the text, and make it a consistent number of lines so
    # that the output box doesn't grow in height.
    text <- fileReaderData()
    length(text) <- 14
    text[is.na(text)] <- ""
    paste(text, collapse = '\n')
  })


  # ============================================================
  # This part of the code monitors the file for changes once
  # every four seconds.

  pollData <- reactivePoll(4000, session,
    # This function returns the time that the logfile was last
    # modified
    checkFunc = function() {
      if (file.exists(logfilename))
        file.info(logfilename)$mtime[1]
      else
        ""
    },
    # This function returns the content of the logfile
    valueFunc = function() {
      readLines(logfilename)
    }
  )

  output$pollText <- renderText({
    # Read the text, and make it a consistent number of lines so
    # that the output box doesn't grow in height.
    text <- pollData()
    length(text) <- 14
    text[is.na(text)] <- ""
    paste(text, collapse = '\n')
  })
}
