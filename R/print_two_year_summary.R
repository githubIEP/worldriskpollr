#' Prints question summary for two years
#'
#' @param question_summary data.frame, summarises selected question
#'
.print_two_year_summary <- function(question_summary) {
  message(paste("This questions was asked in", paste(question_summary$year, collapse = " and ")))
  for (i in 1:nrow(question_summary)) {
    message(paste("In", question_summary$year[i], "it was asked in", question_summary$n[i], "regions"))
  }
}
