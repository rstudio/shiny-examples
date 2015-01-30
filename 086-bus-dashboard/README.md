The script in the `metrotransit-data/` directory will fetch schedule data for the Twin Cities Metro Transit. This data is updated weekly.

The 00-fetch-data.R script should be executed in the `metrotransit-data/` directory. It fetches the data and saves some of the tables as .rds files. The bus app will read in the .rds files for route information.

Information about schedule data: http://datafinder.org/metadata/transit_schedule_google_feed.html

Data format reference: https://developers.google.com/transit/gtfs/reference?csw=1
