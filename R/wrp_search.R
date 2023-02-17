#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param string string, search term for the World Risk Poll questions
#'
#' @importFrom tidyr unnest
#'
#' @return data frame with World Risk Poll questions containing the search term.
#' @examples
#' wrp <- wrp_search(string = "violence")
#' @export
#'

wrp_search <- function(string = "violence") {
  dict <- wrp_questions %>% unnest(levels)
  matches <- unique(c(
    grep(string, dict$label, ignore.case = TRUE),
    grep(string, dict$levels, ignore.case = TRUE)
  ))
  out <- dict[matches, c("WRP_UID", "label", "levels")]
  names(out) <- c("wrp_question_uid", "question", "responses")
  if (nrow(out) == 0) {
    message("No instances of that search term in the World Risk Poll questions")
  }
  return(out)
}
