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

wrp_aggregate <- function() {

  df <- wrp
  dict = wrp_dictionary
  
  message("Please Select Survey Question")
  question = dict %>% filter(question) 
  q = menu(question$label) 
  q = match(question$variable[q], dict$variable)
  disaggregation = dict %>% filter(disaggregator)
  dis = menu(disaggregation$label)
  dis = match(disaggregation$variable[dis], dict$variable)
  yr = match("year", dict$variable)
  wgt = ifelse(dis == 2, match("wgt", dict$variable), match("projectionWeight", dict$variable))
  df = df[, c(dis, yr, wgt, q)] %>% filter(complete.cases(.))
  names(df) = c("dis", "year", "wgt", "q")
  wrp_agg <- df %>%
    group_by(dis, year, q) %>%
    summarise(weightedCount = sum(.data$wgt)) %>%
    #mutate(question = labelled::var_label(.data$q)) %>%
    ungroup() %>%
    group_by(dis, year) %>%
    mutate(percentage = weightedCount / sum(weightedCount) * 100) %>%
    ungroup() %>%
    rename(response = q, disaggregation = dis) %>%
    select(disaggregation, year, response, percentage) %>%
    sjlabelled::label_to_colnames()

  wrp_agg

}
