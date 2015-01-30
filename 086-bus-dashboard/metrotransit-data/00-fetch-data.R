# Information about data source at:
# http://datafinder.org/metadata/transit_schedule_google_feed.html

# Data reference:
# https://developers.google.com/transit/gtfs/reference?csw=1

# These are the data files we want to use
datafiles <- c("shapes.txt", "trips.txt")

# =============================================================================
# Download and unzip data
# =============================================================================
download.file("ftp://gisftp.metc.state.mn.us/google_transit.zip",
              "google_transit.zip")

dir.create("raw", showWarnings = FALSE)

# Extract just the specified data files
unzip("google_transit.zip", files = datafiles, exdir = "raw")
unlink("google_transit.zip")

# =============================================================================
# Read in each of the data objects and save to an RDS file
# =============================================================================
# Clean out old files
unlink("rds", recursive = TRUE)

dir.create("rds", showWarnings = FALSE)

for (datafile in datafiles) {
  infile <- file.path("raw", datafile)
  outfile <- file.path("rds", sub("\\.txt$", ".rds", datafile))

  cat("Converting ", infile, " to ", outfile, ".\n", sep = "")

  obj <- read.csv(infile, stringsAsFactors = FALSE)
  saveRDS(obj, outfile)
}

# Remove raw data files
unlink("raw", recursive = TRUE)
