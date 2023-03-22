
get_transit_gtfs <- memoise::memoise(function() {
    download_and_read(
        url = "https://svc.metrotransit.org/mtgtfs/gtfs.zip",
        # Use consistent location for caching within R session
        destfile = file.path(tempdir(), "gtfs.zip"),
        read_fn = function(x) {
            gtfstools::read_gtfs(x, c("trips", "shapes"))
        }
    )
})
