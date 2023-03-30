#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param df data frame, a demographic category by which to aggregate
#'
#' @importFrom dplyr mutate group_by_at ungroup summarise select
#' @importFrom sjlabelled label_to_colnames
#' @importFrom rlang .data
#'
#' @return data frame with aggregated World Risk Poll question data
#' @noRd
wrp_aggregate <- function(df) {
  df <- df %>%
    group_by_at(c(1, 2, 3, 5, 6)) %>%
    summarise(weightedCount = sum(.data$wgt)) %>%
    ungroup() %>%
    group_by_at(c(1, 2, 3)) %>%
    mutate(percentage = .data$weightedCount /
      sum(.data$weightedCount) * 100) %>%
    ungroup() %>%
    label_to_colnames() %>%
    select(-.data$weightedCount)
  return(df)
}
