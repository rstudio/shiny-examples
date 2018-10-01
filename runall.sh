#!/bin/bash

# If desired, you can call it with a number, e.g. "runall 013" to
# skip examples up to but not including 013-selectize.

trap '' SIGINT

shiny () {
  echo $i
  R --quiet --slave -e "shiny::runApp(\"$1\", port=5151, launch.browser=TRUE)"
}

run_26 () {
  echo $i
  R --quiet --slave -e "rmarkdown::run(\"$1\", shiny_args = list(launch.browser = TRUE))"
}

for i in $( ls -d */ ); do
  if [ "$i" \> "$1" ]; then
    if [ "$i" != "docker/" ]; then
      if [ "$i" = "026-shiny-inline/" ]; then
        run_26 $i
      else
        shiny $i
      fi
    fi
  fi
done
