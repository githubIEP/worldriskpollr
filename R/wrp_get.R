#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param geography string, a demographic category by which to aggregate, needs to be one of "country", "region" or "income"
#' @param question_uid string, the number code for the survey question to focus on
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

wrp_get <- function(geography, question_uid = NULL) {
  df <- wrp_data
  dict <- wrp_dictionary
  #error check that geograpy and questions are in dataset
  geography <- case_when(
    geography == "country" ~ regions$pos[1],
    geography == "region" ~ regions$pos[2],
    geography == "income" ~ regions$pos[3]
 if (is.null(question_uid)) {
    message("Please Select Survey Question")
    tmp <- menu(questions$label)
    question_uid <- questions$pos[tmp]
 }else{
    question_uid = match(questions_uid, questions$WRP_UID)
    questions_uid = questions$pos[questions_uid]
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
