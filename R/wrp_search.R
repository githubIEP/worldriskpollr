#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param aggregation string, a demographic category by which to aggregate
#' @param survey_question string, the code for the survey question to focus on
#' @param tagged logical, if TRUE, retrieve human-readable response and aggregations, if FALSE, retrieve dbl+lab
#'
#' @importFrom dplyr mutate rename group_by ungroup summarise relocate case_when bind_rows
#' @importFrom labelled var_label
#'
#' @return data frame with aggregated World Risk Poll question data
#' @export
#'

wrp_search <- function (string = "violence") 
{
  dict = wrp::wrp_dictionary %>% unnest(levels)
  matches = unique(c(grep(string, dict$label, ignore.case = TRUE), grep(string, dict$levels, ignore.case = TRUE)))
  out = dict[matches, c("pos", "label", "levels")] %>% rename(wrp_question_id =pos, question = label, responses = levels)
  if(nrow(out) == 0){
    message("No instances of that search term in the World Risk Poll questions")
  }
  return(out)
}