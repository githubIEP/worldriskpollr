#' @title Download optional data for this package if required.
#'
#' @description Ensure that the optioanl data is available locally in the package cache. Will try to download the data only if it is not available.
#' 
#' @importFrom pkgfilecache get_pkg_info ensure_files_available get_filepath get_cache_dir
#'
#' @return Named list. The list has entries: "available": vector of strings. The names of the files that are available in the local file cache. You can access them using get_optional_data_file(). "missing": vector of strings. The names of the files that this function was unable to retrieve.
#'

.wrp_processing <- function(pkg_info){
  raw <- haven::read_sav(pkgfilecache::get_filepath(pkg_info, "lrf_wrp_2021_full_data.sav", mustWork=mustWork))
  raw$projectionWeight <- raw$PROJWT_2019
  raw$projectionWeight <- ifelse(is.na(raw$projectionWeight),
                                 raw$PROJWT_2021, raw$projectionWeight)
  wrp_data <- raw %>%
    janitor::clean_names("lower_camel") %>%
    # change 1: convert haven_labelled variables to factors ----
  mutate_if(haven::is.labelled, haven::as_factor)
  wrp_data$countryIncomeLevel <- as.character(wrp_data$countryIncomeLevel2019)
  wrp_data$countryIncomeLevel <- ifelse(is.na(wrp_data$countryIncomeLevel),
                                        as.character(wrp_data$countryIncomeLevel2021), wrp_data$countryIncomeLevel
  )
  wrp_dictionary <- labelled::generate_dictionary(wrp_data) %>%
    mutate(regional_disaggregate = pos %in% c(2, 6, 233)) %>%
    mutate(disaggregator = pos %in% c(3, 13:21)) %>%
    mutate(question = substr(variable, 1, 1) == "q" |
             substr(variable, 1, 2) == "vh") %>%
    mutate(needed = variable %in% c("year", "wgt", "projectionWeight"))
  wrp_dictionary$label <- ifelse((wrp_dictionary$variable == "countryIncomeLevel"),
                                 "World Bank Income Levels", wrp_dictionary$label)
  wrp_dictionary$label <- ifelse((wrp_dictionary$variable == "projectionWeight"),
                                 "projectionWeight", wrp_dictionary$label)
  wrp_dictionary <- wrp_dictionary[wrp_dictionary$regional_disaggregate |
                                     wrp_dictionary$disaggregator |
                                     wrp_dictionary$question |
                                     wrp_dictionary$needed, ]
  wrp_data = wrp_data[,c(wrp_dictionary$pos)]
  wrp_dictionary$pos = match(wrp_dictionary$variable, names(wrp_data))
  wrp_year_col <- match("year", wrp_dictionary$variable)
  wrp_weight_col <- match("wgt", wrp_dictionary$variable)
  wrp_projweight_col <- match("projectionWeight", wrp_dictionary$variable)
  wrp_dictionary$WRP_UID <- NA
  regional_ids <- c("country", "region", "income")
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
  wrp_needed = wrp_dictionary[substr(wrp_dictionary$WRP_UID, 1, 4) == "NEED", ]
  #wrp_data = remove_all_labels(wrp_data)
  wrp_regions = wrp_regions %>% select(-levels)
  wrp_disaggregations = wrp_disaggregations %>% select(-levels)
  # wrp_region_1st_nom = wrp_data %>% select(c(1,4,5, 103)) %>% distinct()
  # wrp_data = wrp_data %>% select(-c(5, 103)) 
  save(wrp_data,
       wrp_year_col,
       wrp_projweight_col,
       wrp_weight_col,
       wrp_regions,
       wrp_disaggregations,
       wrp_questions, file = .wrp_sysdata_file_path())
}
