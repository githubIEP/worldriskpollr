#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param df data frame, a demographic category by which to aggregate
#'
#' @importFrom dplyr mutate rename group_by_at ungroup summarise select mutate_if
#' @importFrom janitor clean_names
#'
#' @return data frame with aggregated World Risk Poll question data
#'
wrp_clean <- function(df) {
  df <- df %>% mutate(disaggregation = names(df)[2], question = names(df)[4])
  names(df)[1] <- "geography"
  names(df)[4] <- "response"
  names(df)[2] <- "group"
  df$year <- as.numeric(df$`Year of interview`)
  df <- df %>%
    mutate_if(is.factor, as.character) %>%
    clean_names("lower_camel")
  df <- df[, c(1, 6, 2, 8, 7, 4, 5)]
  return(df)
}
