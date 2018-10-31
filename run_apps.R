# Source this script while your current directory is the shiny-examples repo root.
#
# Functions:
# - `auto_run()` runs each app one at a time. Each time you exit Shiny, it waits
#   one second before launching the next app. If you want to stop looping, just
#   hit Escape again during the one second wait.
# - `run_next()` runs just the next app; when you exit, you return to the prompt.
# - `rerun()` runs the previously run app.
#
# The `last_app` variable keeps track of which app was run last; it's an index
# into the `dirs` variable. If you want to jump to `133-async-hold-inputs`, for
# example, you could do:
#
# ```r
# last_app <- which(grepl("133", dirs))
# rerun()
# ```
#
# To start over from the beginning, set `last_app <- 0L` (or call `reset()`).

dirs <- grep("^\\./\\d\\d\\d", list.dirs(recursive = FALSE), value = TRUE)
if (!exists("last_app")) {
  last_app <- 0L
}

run_next <- function() {
  if (last_app >= length(dirs)) {
    message("No more apps!")
    return(invisible(FALSE))
  }

  last_app <<- last_app + 1L
  rerun()
}

# Run most recently run app, without advancing.
rerun <- function() {
  if (last_app == 0L) {
    warning("No app to run")
    return()
  }
  message("Running ", dirs[[last_app]])
  if (grepl("026", dirs[[last_app]])) {
    rmarkdown::run(file.path(dirs[[last_app]], "index.Rmd"))
  } else {
    shiny::runApp(dirs[[last_app]])
  }
}

skip_next <- function() {
  if (last_app >= length())
    last_app <<- last_app + 1L
  message("Skipping ", dirs[[last_app]])
}

reset <- function() {
  last_app <<- 0L
}

auto_run <- function() {
  while (TRUE) {
    tryCatch(
      {
        run_next()
        break
      },
      interrupt = function(cond) {
        message("Launching next app in 1 second...")
        Sys.sleep(1)
      }
    )
  }
}
