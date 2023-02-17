#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param geography string, a demographic category by which to aggregate, needs to be one of "country", "region" or "income"
#' @param question_uid string, the number code for the survey question to focus on
#'
#' @importFrom dplyr filter mutate rename group_by ungroup summarise relocate case_when bind_rows arrange
#' @importFrom utils menu
#' @importFrom stats complete.cases
#' @importFrom rlang .data
#'
#' @return data frame with aggregated World Risk Poll question data
#'
#' @examples wrp_get(geography = "country", question_uid = "Q1")
#' # To run interactively and select question
#' # wrp_get()
#' @export

wrp_get <- function(geography = "country", question_uid = "Q1") {
  df <- wrp_data
  dict <- wrp_dictionary
  wrp_geography_col = .get_regional_column(geography)
  wrp_question_col = .get_question_column(question_uid)
  wrp_wgt_col = .get_weight_column(wrp_geography_col)
  wrp_agg <- lapply(wrp_disaggregations$pos, function(i) {
    tmp <- df[, c(wrp_geography_col, i, wrp_year_col, wrp_wgt_col, 
                  wrp_question_col)]
    tmp <- tmp[!is.na(tmp[, 5]), ] %>%
      wrp_aggregate() %>%
      wrp_clean()
  }) %>% bind_rows()
  message(paste("You have selected:", question_uid))
  message("This question asks:")
  message(wrp_agg$question[1])
  question_summary = wrp_agg %>% group_by(year) %>% summarise(n = length(unique(geography))) %>% ungroup() %>%
    arrange(year)
  .print_question_summary(question_summary)
  return(wrp_agg)
}
