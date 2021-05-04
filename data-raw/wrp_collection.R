library(tidyverse)
library(here)
library(labelled)

# get raw data -----------------------------------------------------------------
tmp <- tempfile()
download.file("http://doc.ukdataservice.ac.uk/doc/8739/mrdoc/excel/8379_lrf_public_file_review_excel_for_website.xlsx",
              tmp, mode = "wb")

raw <- readxl::read_excel(tmp)

# clean raw data ---------------------------------------------------------------
wrp <- raw %>%
  janitor::clean_names("lower_camel") %>%
  mutate(iso3C = countrycode::countrycode(country, "country.name", "iso3c", custom_match = c("Kosovo" = "KSV"))) %>%
  relocate(iso3C, .after = country)

dict <- readr::read_csv(here::here("data-raw", "dictionary.csv"))

# labeled, wide data -----------------------------------------------------------
# label columns
var_label(wrp) <- dict %>% distinct(question_description) %>% pull()

# label values
for (variable in dict %>% distinct(variable_name) %>% filter(!variable_name %in% c("wpidRandom", "country", "iso3C", "year", "wgt", "projectionWeight", "age")) %>% pull()) {

  code <- dict %>%
    filter(variable_name == variable) %>%
    pull(code)

  response <- dict %>%
    filter(variable_name == variable) %>%
    pull(response)

  for (i in 1:length(code)) {

    val_label(wrp[, variable], code[[i]]) <- response[[i]]

  }

}

usethis::use_data(wrp, overwrite = TRUE)
