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

wrp_get <- function(geography = NULL, question = NULL) {

  df <- wrp::wrp
  dict <- wrp::wrp_dictionary
  if(is.null(geography)){
    message("Please Select Geography")
    geography = dict %>% filter(regional_disaggregate)
    tmp = menu(geography$label)
    geography = match(geography$variable[tmp], dict$variable)
  }else{
    geography = case_when(geography == "country" ~ 2,
                          geography == "region" ~ 7,
                          geography  == "income" ~ 234)
  }
  if(is.null(question)){
    message("Please Select Survey Question")
    question = dict %>% filter(question) 
    tmp = menu(question$label) 
    question = match(question$variable[tmp], dict$variable)
  }
  yr = match("year", dict$variable)
  wgt = ifelse(geography == 2, match("wgt", dict$variable), match("projectionWeight", dict$variable))

  disaggregation = dict %>% filter(disaggregator)
  
  wrp_agg  = df[, c(geography, yr, wgt, question)] %>% filter(complete.cases(.)) %>%
    mutate(None = "Aggregate") %>% relocate(None, .after = 1) %>%
    wrp_aggregate() %>% wrp_clean()
  wrp_dis = lapply(disaggregation$pos, function(i){
    tmp = df[, c(geography, i, yr, wgt, question)] %>% filter(complete.cases(.))
    tmp = tmp %>% wrp_aggregate() %>% wrp_clean()}) 
  wrp_dis = wrp_dis %>% bind_rows()
  wrp_agg = wrp_agg %>% rbind(wrp_dis)
  return(wrp_agg)

}
