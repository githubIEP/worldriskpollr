#' Prints question summary for one year
#'
#' @param question_summary data.frame, summarises selected question
#' @noRd
.print_one_year_summary <- function(question_summary) {
  message(paste("This questions was only asked in", question_summary$year))
  for (i in seq_len(nrow(question_summary))) {
    message(paste(
      "In", question_summary$year[i], "it was asked in",
      question_summary$n[i],
      "of the selected geographies"))
  }
}
