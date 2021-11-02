# Converts countries.geojson to sf file and saves as RDS. This is
# to spare people from needing to have rgdal installed just to
# run the app.

library(rgdal)
library(sf)

download.file("https://raw.githubusercontent.com/rstudio/leaflet/main/docs/json/countries.geojson", "countries.geojson")
countries <- readOGR("countries.geojson", "OGRGeoJSON")
saveRDS(st_as_sf(countries), "countries.rds")
message("Saved countries.rds")
