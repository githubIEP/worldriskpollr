#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param aggregation string, a demographic category by which to aggregate
#' @param survey_question string, the code for the survey question to focus on
#' @param tagged logical, if TRUE, retrieve human-readable response and aggregations, if FALSE, retrieve dbl+lab
#'
#' @importFrom dplyr mutate rename group_by ungroup summarise relocate case_when
#' @importFrom labelled var_label
#'
#' @return data frame with aggregated World Risk Poll question data
#' @export
#'

wrp_aggregate <- function(aggregation, survey_question, tagged = c(TRUE, FALSE)) {

  df <- wrp::wrp

  if (tagged == TRUE) {

    df <- df %>% mutate(across(where(is.labelled), to_factor))

  }

  wrp_agg <- df %>%
    rename(focus = survey_question) %>%
    group_by(.data$year,
             switch(aggregation,
                    "country" = country,
                    "iso3C" = iso3C,
                    "year" = year,
                    "globalRegion" = globalRegion,
                    "region" = region,
                    "government" = government,
                    "countryIncomeLevel" = countryIncomeLevel,
                    "age" = age,
                    "gender" = gender,
                    "education" = education,
                    "incomeFeelings" = incomeFeelings,
                    "income5" = income5,
                    "urbanicity" = urbanicity,
                    "householdSize" = householdSize,
                    "childrenInHousehold" = childrenInHousehold),
             .data$focus) %>%
    summarise(weightedCount = case_when(aggregation == "country" ~ sum(.data$wgt),
                                        TRUE ~ sum(.data$projectionWeight))) %>%
    mutate(question = labelled::var_label(.data$focus)) %>%
    rename(aggregation = "switch(...)", response = "focus") %>%
    relocate(question, .before = response) %>%
    ungroup()

  labelled::var_label(wrp_agg$question) <- "Survey question"
  labelled::var_label(wrp_agg$response) <- "Survey response"
  labelled::var_label(wrp_agg$weightedCount) <- "Representative count of respondents"

  wrp_agg

}
