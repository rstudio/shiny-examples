# enable reactlog recording
options(shiny.reactlog = TRUE)

# Source this script while your current directory is the shiny-examples repo root.
#
# Options:
# To use something other than the defaults, set one or more of these global
# variables before running the script.
# - new_process: If TRUE (the default) launch each app in a separate R process.
#     Note: to use the RStudio viewer, this must be FALSE.
# - launch_browser: Controls whether to launch a new browser for each app. If
#     `new_process` is TRUE, then this defaults to FALSE. If `new_process` is
#     FALSE, then this uses the usual default, which may launch a RStudio
#     viewer, an external browser, or do nothing, depending on the environment.
# - port: Defaults to 8000.
# - display_mode: Controls the `display.mode` parameter to `runApp()`. Defaults
#     to "auto".
#
# Functions:
# - `auto_run()` runs each app one at a time. Each time you exit Shiny, it waits
#   one second before launching the next app. If you want to stop looping, just
#   hit Escape again during the one second wait.
# - `run_next()` runs just the next app; when you exit, you return to the prompt.
# - `rerun()` runs the previously run app.
#
#
# To run apps in separate processes, on port 8000, and without launching a
# browser, run:
#
# ```r
# auto_run()
# ```
#
# To run apps in this processes, on port 8000, and with the RStudio viewer, run
# this in RStudio:
#
# ```r
# new_process <- FALSE
# # Source the script here
# auto_run()
# ```
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

if (!exists("new_process")) {
  new_process <- TRUE
}

# Args to pass to runApp()
if (!exists("port")) {
  port <- 8000
}
if (!exists("launch_browser")) {
  if (new_process) {
    # If running apps in a separate process, default is to not to launch a browser.
    launch_browser <- FALSE
  } else {
    # If running in this process, use the usual default.
    launch_browser <- getOption("shiny.launch.browser", interactive())
  }
}
if (!exists("display_mode")) {
  display_mode <- "auto"
}

run_next <- function() {
  if (last_app >= length(dirs)) {
    message("No more apps!")
    return(invisible(FALSE))
  }

  last_app <<- last_app + 1L
  rerun()
}

run_app <- function(app, port, launch_browser, display_mode = "auto") {
  message("Running ", app)

  if (grepl("026", app) || grepl("169.*a$", app)) {

    rmarkdown::run(
      file.path(app, "index.Rmd"),
      shiny_args = list(
        port = port,
        launch.browser = launch_browser,
        display.mode = display_mode
      )
    )
  } else {
    shiny::runApp(
      app,
      port = port,
      launch.browser = launch_browser,
      display.mode = display_mode
    )
  }
}

# Run most recently run app, without advancing.
rerun <- function() {
  if (last_app == 0L) {
    warning("No app to run")
    return()
  }

  args <- list(
    app = dirs[[last_app]],
    port = port,
    launch_browser = launch_browser,
    display_mode = display_mode
  )

  if (new_process & !grepl("^169", args$app)) {
    callr::r(run_app, args, show = TRUE)
  } else {
    do.call(run_app, args)
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

url_links <- function(base_url) {
  links <- paste0(base_url, sub("^\\.", "", dirs), "/")
  cat(paste0(links, collapse = "\n"), "\n", sep = "")
  invisible(links)
}

# Install packages needed for examples
source("install_deps.R", echo = TRUE)
