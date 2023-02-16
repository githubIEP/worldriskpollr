#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param string string, a search term to look for in the World Risk Poll questions
#'
#' @importFrom dplyr mutate rename group_by ungroup summarise relocate case_when bind_rows
#' @importFrom tidyr unnest
#'
#' @return data frame with World Risk Poll questions that contain the search term.
#' @examples
#' wrp <- wrp_search(string = "violence")
#' @export
#'

wrp_search <- function(string = "violence") {
  dict <- wrp_dictionary %>% unnest(levels)
  matches <- unique(c(grep(string, dict$label, ignore.case = TRUE), grep(string, dict$levels, ignore.case = TRUE)))
  out <- dict[matches, c("pos", "label", "levels")]
  names(out) <- c("wrp_question_number", "question", "responses")
  if (nrow(out) == 0) {
    message("No instances of that search term in the World Risk Poll questions")
  }
  return(out)
}
