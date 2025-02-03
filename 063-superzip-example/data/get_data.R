# get census data
#install.packages("tidycensus")
library(tidycensus)
library(tidyverse)
# census_api_key(key = "YOURKEYHERE", install = T)

# most variables can be gotten in 1 call. still need population
acs_data <- get_acs(geography = "zcta", variables = c("S1501_C02_015E", "S1903_C01_001E", "S1903_C03_001E"))

acs_data <- acs_data %>%
  mutate(variable = recode(variable, "S1501_C02_015" = "Percent bachelor's Degree or Higher",
                           "S1903_C01_001" = "Number of Households",
                           "S1903_C03_001" = "Median income in past 12 mos (2017 inflation-adjusted US$)"))

# get population
acs_data_pop <- get_acs(geography = "zcta", variables = "DP05_0021")

acs_data_pop <- mutate(acs_data_pop, variable = "Adult population (18+)")

acs_data_all <- bind_rows(acs_data, acs_data_pop)


# rank by income, college, and combined
acs_data_scored <- acs_data_all %>% select(-NAME, -moe) %>% arrange(GEOID) %>%
  spread(variable, estimate) %>%
  mutate(college_rank = percent_rank(`Percent bachelor's Degree or Higher`),
         income_rank = percent_rank(`Median income in past 12 mos (2017 inflation-adjusted US$)`),
         centile = (college_rank + income_rank)/2,
         superzip = centile > 0.95) %>%
  arrange(desc(centile))

# tidy up for app
superzips <- acs_data_scored %>%
  filter(!is.na(centile)) %>%
  arrange(desc(centile)) %>%
  mutate(superzip = as.integer(superzip),
         rank = row_number()) %>%
  select(zipcode = GEOID,
         centile,  superzip, rank,
         adultpop = `Adult population (18+)`,
         households = `Number of Households`,
         college = `Percent bachelor's Degree or Higher`,
         income = `Median income in past 12 mos (2017 inflation-adjusted US$)`)

zip_info <- read_csv("data/zip_code_database.csv")
zip_info2 <- zip_info %>% select(zip, primary_city, state, county, latitude, longitude)

# get zip coords
superzips <- superzips %>% left_join(zip_info2, by = c("zipcode" = "zip"))
