library(tidyverse)
library(here)
library(labelled)
library(sjlabelled)
source("./data-raw/read_zip_online.R")
# get raw data -----------------------------------------------------------------

raw <- read_zip_online("https://wrp.lrfoundation.org.uk/lrf_wrp_2021_full_data.zip", file.to.extract = 1)
raw$projectionWeight = raw$PROJWT_2019
raw$projectionWeight = ifelse(is.na(raw$projectionWeight), raw$PROJWT_2021, raw$projectionWeight)

wrp <- raw %>%
  janitor::clean_names("lower_camel") %>%
  mutate(iso3C = countrycode::countrycode(country, "country.name", "iso3c", custom_match = c("Kosovo" = "KSV"))) %>%
  relocate(iso3C, .after = country) %>%
  # change 1: convert haven_labelled variables to factors ----
  mutate_if(haven::is.labelled, haven::as_factor) 
wrp$countryIncomeLevel = as.character(wrp$countryIncomeLevel2019)
wrp$countryIncomeLevel = ifelse(is.na(wrp$countryIncomeLevel), 
                                as.character(wrp$countryIncomeLevel2021), wrp$countryIncomeLevel)
wrp_dictionary = labelled::generate_dictionary(wrp) %>%
  mutate(regional_disaggregate = pos %in% c(2,7,234)) %>%
  mutate(disaggregator = pos %in% c(14:21)) %>%
  mutate(question = substr(variable, 1,1) == "q" | substr(variable, 1,2) == "vh")
wrp_dictionary$label = ifelse(is.na(wrp_dictionary$label), "World Bank Income Levels", wrp_dictionary$label)

# wrp = wrp %>% 
# # change 2: convert variable labels to variable names ----
#   sjlabelled::label_to_colnames() 

usethis::use_data(wrp, overwrite = TRUE)
usethis::use_data(wrp_dictionary, overwrite = TRUE)
