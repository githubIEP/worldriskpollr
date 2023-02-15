#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param df string, a demographic category by which to aggregate
#'
#' @importFrom dplyr mutate rename group_by_at ungroup summarise select
#' @importFrom sjlabelled label_to_colnames
#'
#' @return data frame with aggregated World Risk Poll question data
#'
wrp_clean = function(df){
  df = df %>% mutate(disaggregation = names(df)[2], question = names(df)[4])
  names(df)[4] = "response"
  names(df)[2] = "group"
  df$year = as.numeric(df$`Year of interview`)
  df = df %>% mutate_if(is.factor, as.character) %>%
    janitor::clean_names("lower_camel") 
  df = df[, c(1, 6, 2, 8, 7, 4, 5)]
  return(df)
}