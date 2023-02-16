#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param geography string, a demographic category by which to aggregate, needs to be one of "country", "region" or "income"
#' @param question_number number, the number code for the survey question to focus on
#'
#' @importFrom dplyr filter mutate rename group_by ungroup summarise relocate case_when bind_rows
#' @importFrom utils menu
#' @importFrom stats complete.cases
#' @importFrom rlang .data
#'
#' @return data frame with aggregated World Risk Poll question data
#'
#' @examples wrp_get(geography = "country", question_number = 80)
#' # To run interactively and select question
#' # wrp_get()
#' @export
#'

wrp_get <- function(geography = NULL, question_number = NULL) {
  df <- wrp_data
  dict <- wrp_dictionary
  if (is.null(geography)) {
    message("Please Select Geography")
    geography <- dict %>% filter(.data$regional_disaggregate)
    tmp <- menu(geography$label)
    geography <- match(geography$variable[tmp], dict$variable)
  } else {
    geography <- case_when(
      geography == "country" ~ 2,
      geography == "region" ~ 7,
      geography == "income" ~ 234
    )
  }
  if (is.null(question_number)) {
    message("Please Select Survey Question")
    question <- dict %>% filter(question)
    tmp <- menu(question$label)
    question_number <- match(question$variable[tmp], dict$variable)
  }
  yr <- match("year", dict$variable)
  wgt <- ifelse(geography == 2, match("wgt", dict$variable), match("projectionWeight", dict$variable))

  disaggregation <- dict %>% filter(.data$disaggregator)

  wrp_agg <- df[, c(geography, yr, wgt, question_number)]
  wrp_agg <- wrp_agg[!is.na(wrp_agg[, 4]), ] %>%
    mutate(None = "Aggregate")
  wrp_agg <- wrp_agg[, c(1, 5, 2, 3, 4)] %>%
    wrp_aggregate() %>%
    wrp_clean()
  wrp_dis <- lapply(disaggregation$pos, function(i) {
    tmp <- df[, c(geography, i, yr, wgt, question_number)]
    tmp <- tmp[!is.na(tmp[, 5]), ] %>%
      wrp_aggregate() %>%
      wrp_clean()
  })
  wrp_dis <- wrp_dis %>% bind_rows()
  wrp_agg <- wrp_agg %>% rbind(wrp_dis)
  return(wrp_agg)
}
