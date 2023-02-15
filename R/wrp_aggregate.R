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
wrp_aggregate = function(df){
  if("projectionWeight" %in% names(df)){
    df =df %>% rename(wgt = projectionWeight)
  }
  df = df %>%
    group_by_at(c(1,2,3,5)) %>%
    summarise(weightedCount = sum(.data$wgt)) %>%
    ungroup() %>%
    group_by_at(c(1,2)) %>%
    mutate(percentage = weightedCount / sum(weightedCount) * 100) %>%
    ungroup() %>%
    label_to_colnames() %>%
    select(-weightedCount)
}