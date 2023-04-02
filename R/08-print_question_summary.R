#' Wrapper function for question summaries
#'
#' @param question_summary data.frame, summarises selected question
#' @noRd

.print_question_summary <- function(question_summary) {
  if (nrow(question_summary) == 2) {
    .print_two_year_summary(question_summary)
  } else {
    .print_one_year_summary(question_summary)
  }
}
