routes <- readRDS("rds/routes.rds")
routes %>% filter(route_id == "6-75") -> r2

trips <- readRDS("rds/trips.rds")
trips %>% filter(route_id == "6-75") -> t2
trips %>% filter(trip_headsign == "Northbound 6  Downtown / Via  Xerxes") -> t3


stop_times <- readRDS("rds/stop_times.rds")
routes %>% filter(route_id == "6-75") -> t2



shapes <- readRDS("rds/shapes.rds")
shapes %>% filter(shape == "6-75") %>% str


# To get shape:
# Route number (6)
# route_id ("6-75")
# Filter in trips$route_id table
# Get most common shape_id
# use that shape_id to filter from shapes

library(dplyr)
get_route_shape <- function(route, trips, shapes) {
  routeid <- paste0(route, "-75")
  
  # For this route, get all the shape_ids listed in trips, and a count of how
  # many times each shape is used. We'll just pick the most commonly-used shape.
  shape_counts <- trips %>%
    filter(route_id == routeid) %>%
    group_by(shape_id) %>%
    summarise(n = n()) %>%
    arrange(-n)
  
  shapeid <- shape_counts$shape_id[1]

  # Get the coordinates for the shape_id
  shapes %>% filter(shape_id == shapeid)
}
get_route_shape(6, trips, shapes)
# 
