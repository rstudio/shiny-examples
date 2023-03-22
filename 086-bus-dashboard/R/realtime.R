library(RProtoBuf)
library(dplyr)
library(purrr)


realtime_info <- memoise::memoise(
    function() {

        # Altered from https://stackoverflow.com/a/71552368
        # to support https://svc.metrotransit.org/
        # Only add shapes if needed
        if (! ("transit_realtime.VehiclePosition" %in% ls("RProtoBuf:DescriptorPool"))) {
            download_and_read(
                url = "https://gtfs.org/realtime/gtfs-realtime.proto",
                # Use consistent location for caching within R session
                destfile = file.path(tempdir(), "gtfs-realtime.proto"),
                # Load proto shapes into RProtoBuf
                read_fn = readProtoFiles
            )
            # # View proto shapes
            # ls("RProtoBuf:DescriptorPool")
        }

        download_and_read(
            url = "https://svc.metrotransit.org/mtgtfs/vehiclepositions.pb",
            destfile = tempfile(fileext = ".pb"),
            clean = TRUE,
            read_fn = function(vehicle_positions) {
                read(
                    transit_realtime.FeedMessage,
                    vehicle_positions
                )[["entity"]]
            }
        )
    },
    # Cache for 10 seconds (then website will refresh data every 15s)
    # Helps avoid duplicate work during startup
    cache = cachem::cache_mem(max_age = 10)
)


# Route
# Direction
# VehicleLongitude
# VehicleLatitude
realtime_locations <- function(..., veh_info = realtime_info(), gtfs = get_transit_gtfs()) {
    locations <-
        veh_info %>%
        map_dfr(~ {
            vehicle <- .x$vehicle
            trip <- vehicle$trip
            position <- vehicle$position
            tibble(
                Route = trip$route_id,
                trip_id = trip$trip_id,
                VehicleLongitude = position$longitude,
                VehicleLatitude = position$latitude
            )
        }) %>%
        # Remove vehicles with no location
        filter(VehicleLatitude > 1)

    locations %>%
        left_join(
            gtfs$trips %>%
                select(trip_id, direction),
            by = "trip_id"
        ) %>%
        # Add route names
        # 1=South, 2=East, 3=West, 4=North
        mutate(
            Direction = c("SB" = 1, "EB" = 2, "WB" = 3, "NB" = 4)[direction],
            # Remove unnecessary columns
            trip_id = NULL,
            direction = NULL
        )
}
