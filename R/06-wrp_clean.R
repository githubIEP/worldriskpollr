#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param df data frame, a demographic category by which to aggregate
#'
#' @importFrom dplyr mutate mutate_if
#' @importFrom janitor clean_names
#'
#' @return data frame with aggregated World Risk Poll question data
#' @noRd
#'
wrp_clean <- function(df) {
  df <- df %>% mutate(disaggregation = names(df)[2], question = names(df)[4])
  names(df)[1] <- "geography"
  names(df)[4] <- "response"
  names(df)[2] <- "group"
  df <- df %>%
    mutate_if(is.factor, as.character) %>%
    clean_names("lower_camel")
  names(df) <- gsub("yearOfInterview", "year", names(df))
  df <- df[, c(1, 6, 3, 7, 4, 5)]
  return(df)
}
