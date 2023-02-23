#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param geography string, a demographic category by which to aggregate,
#' needs to be one of "country", "region" or "income"
#' @param wrp_question_uid string, the number code for the survey
#' question to focus on
#'
#' @importFrom dplyr group_by ungroup summarise bind_rows arrange
#' @importFrom utils menu
#' @importFrom stats complete.cases
#' @importFrom rlang .data
#' @importFrom rlang .data env env_parent set_env
#' @importFrom parallel mclapply detectCores
#' @return data frame with aggregated World Risk Poll question data
#'
#' @examples wrp_get(geography = "country", wrp_question_uid = "Q1")
#' @export

wrp_get <- function(geography = "country", wrp_question_uid = "Q1") {
  # Set up data frame
  wrp_geography_col <- .get_regional_column(geography)
  wrp_question_col <- .get_question_column(wrp_question_uid)
  wrp_wgt_col <- .get_weight_column(wrp_geography_col)
  cores <- detectCores()
  cores <- ifelse(Sys.info()[["sysname"]] == "Windows", 1,
                  min(c(cores, 2)))
  # Aggregate data using weights
  wrp_agg <- mclapply(.pkgenv$wrp$wrp_disaggregations$pos, function(i) {
    tmp <- .pkgenv$wrp$wrp_data[, c(
      wrp_geography_col, i, .pkgenv$wrp$wrp_year_col, wrp_wgt_col,
      wrp_question_col
    )]
    tmp <- tmp[!is.na(tmp[, 5]), ] %>%
      wrp_aggregate() %>%
      wrp_clean()
  }, mc.cores = cores) %>%
    bind_rows()
  # Output summary
  message(paste("You have selected:", wrp_question_uid))
  message("This question asks:")
  message(wrp_agg$question[1])
  question_summary <- wrp_agg %>%
    group_by(.data$year) %>%
    summarise(n = length(unique(.data$geography))) %>%
    ungroup() %>%
    arrange(.data$year)
  .print_question_summary(question_summary)
  return(wrp_agg)
}
