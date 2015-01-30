# This is needed because the shinyapps dependency detection doesn't realize
# that jsonlite::fromJSON needs httr when using URLs.
library(httr)
