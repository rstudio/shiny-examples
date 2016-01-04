#!/bin/bash

# If desired, you can call it with a number, e.g. "runall 013" to
# skip examples up to but not including 013-selectize.

trap '' SIGINT

shiny () {
  echo $i
  R --quiet --slave -e "shiny::runApp(\"$1\", port=5151, launch.browser=TRUE)"
}

for i in $( ls -d */ ); do
  if [ "$i" \> "$1" ]; then
    shiny $i
  fi
done
