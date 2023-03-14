library(tidyverse)
library(here)
library(labelled)
library(sjlabelled)

# get raw data -----------------------------------------------------------------
read_zip_online <- function(url, file_to_extract = NULL) {
  temp <- tempfile()
  download.file(url, temp, mode = "wb")
  x <- unzip(temp, list = TRUE)
  if (is.null(file_to_extract)) {
    print(x)
    file_to_extract <- as.integer(readline(prompt = "Enter file number: "))
  }
  data <- haven::read_sav(unz(temp, x$Name[file_to_extract]))
  unlink(temp)
  return(data)
}

raw <- read_zip_online("https://wrp.lrfoundation.org.uk/lrf_wrp_2021_full_data.zip",
                       file_to_extract = 1)
raw$projectionWeight <- raw$PROJWT_2019
raw$projectionWeight <- ifelse(is.na(raw$projectionWeight),
                               raw$PROJWT_2021, raw$projectionWeight)

wrp_data <- raw %>%
  janitor::clean_names("lower_camel") %>%
  # change 1: convert haven_labelled variables to factors ----
mutate_if(haven::is.labelled, haven::as_factor)
wrp_data$countryIncomeLevel <- as.character(wrp_data$countryIncomeLevel2019)
wrp_data$countryIncomeLevel <- ifelse(is.na(wrp_data$countryIncomeLevel),
                                      as.character(wrp_data$countryIncomeLevel2021), wrp_data$countryIncomeLevel)
wrp_data$world <- "World"
wrp_data$global <- "Global Statistic"
wrp_dictionary <- labelled::generate_dictionary(wrp_data) %>%
  mutate(regional_disaggregate = pos %in% c(2, 6, 233, 234)) %>%
  mutate(disaggregator = pos %in% c(3, 13:21, 235)) %>%
  mutate(question = substr(variable, 1, 1) == "q" |
           substr(variable, 1, 2) == "vh") %>%
  mutate(needed = variable %in% c("year", "wgt", "projectionWeight"))
wrp_dictionary$label <- ifelse((wrp_dictionary$variable == "countryIncomeLevel"),
                               "World Bank Income Levels", wrp_dictionary$label)
wrp_dictionary$label <- ifelse((wrp_dictionary$variable == "projectionWeight"),
                               "projectionWeight", wrp_dictionary$label)
wrp_dictionary$label <- ifelse((wrp_dictionary$variable == "world"),
                               "World", wrp_dictionary$label)
wrp_dictionary$label <- ifelse((wrp_dictionary$variable == "global"),
                               "Global Statistic", wrp_dictionary$label)
wrp_dictionary$label <- ifelse((wrp_dictionary$variable == "projectionWeight"),
                               "projectionWeight", wrp_dictionary$label)
wrp_dictionary <- wrp_dictionary[wrp_dictionary$regional_disaggregate |
                                   wrp_dictionary$disaggregator |
                                   wrp_dictionary$question |
                                   wrp_dictionary$needed, ]
wrp_data <- wrp_data[, c(wrp_dictionary$pos)]
wrp_dictionary$pos <- match(wrp_dictionary$variable, names(wrp_data))
wrp_year_col <- match("year", wrp_dictionary$variable)
wrp_weight_col <- match("wgt", wrp_dictionary$variable)
wrp_projweight_col <- match("projectionWeight", wrp_dictionary$variable)
wrp_dictionary$WRP_UID <- NA
regional_ids <- c("country", "region", "income", "world")
wrp_dictionary$WRP_UID[wrp_dictionary$regional_disaggregate] <- regional_ids
wrp_dictionary$WRP_UID[wrp_dictionary$disaggregator] <-
  paste0("DIS", 1:sum(wrp_dictionary$disaggregator))
wrp_dictionary$WRP_UID[wrp_dictionary$question] <-
  paste0("Q", 1:sum(wrp_dictionary$question))
wrp_dictionary$WRP_UID[wrp_dictionary$needed] <-
  paste0("NEED", 1:sum(wrp_dictionary$needed))
wrp_dictionary <- wrp_dictionary %>%
  select(WRP_UID, pos, variable, label, levels)
wrp_regions <- wrp_dictionary[wrp_dictionary$WRP_UID %in% regional_ids, ]
wrp_disaggregations <- wrp_dictionary[substr(wrp_dictionary$WRP_UID, 1, 3) ==
                                        "DIS", ]
wrp_questions <- wrp_dictionary[substr(wrp_dictionary$WRP_UID, 1, 1) == "Q", ]
wrp_questions$WRP_UID <- toupper(wrp_questions$variable)
wrp_needed <- wrp_dictionary[substr(wrp_dictionary$WRP_UID, 1, 4) == "NEED", ]
wrp_regions <- wrp_regions %>% select(-levels)
wrp_disaggregations <- wrp_disaggregations %>% select(-levels)
wrp <- list(
  "wrp_data" = wrp_data,
  "wrp_year_col" = wrp_year_col,
  "wrp_projweight_col" = wrp_projweight_col,
  "wrp_weight_col" = wrp_weight_col,
  "wrp_regions" = wrp_regions,
  "wrp_disaggregations" = wrp_disaggregations,
  "wrp_questions" = wrp_questions
)
saveRDS(wrp, file = "./data-raw/sysdata.rda", compress = "xz")
