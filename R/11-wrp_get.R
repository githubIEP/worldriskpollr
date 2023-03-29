#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param geography string, a demographic category by which to aggregate,
#' needs to be one of "country", "region", "income" or "world"
#' @param wrp_question_uid string, the number code for the survey
#' question to focus on
#' @param disaggregation integer, one of the following:
#' 0: No disaggregation
#' 1: `age group`, respondent's age group;
#' 2: `gender`, respondent's gender;
#' 3: `education`, respondent's highest level of education;
#' 4: `incomeFeelings`, respondent's feelings about their household income;
#' 5: `income5`, respondent's per capita income quintile;
#' 6: `emp2010`: Employment Status
#' 7: `urbanicity`, respondent's residence: urban or rural;
#' 8: `householdSize`, total number of people in the respondent's household;
#' 9: `childrenInHousehold`, total number of children under 15 in the respondent's household.
#' 
#'
#' @importFrom dplyr group_by ungroup summarise bind_rows arrange
#' @importFrom utils menu
#' @importFrom stats complete.cases
#' @importFrom rlang .data
#' @importFrom rlang .data env env_parent set_env
#' 
#' @return data frame with aggregated World Risk Poll question data
#'
#' @examples wrp_get(geography = "country", wrp_question_uid = "Q1", disaggregation = 0)
#' @export

wrp_get <- function(geography = "country", wrp_question_uid = "Q1", disaggregation = 0) {
  # Set up data frame
  wrp_geography_col <- .get_regional_column(geography)
  wrp_question_col <- .get_question_column(wrp_question_uid)
  wrp_wgt_col <- .get_weight_column(wrp_geography_col)
  wrp_disagg_col <- .get_disagg_column(disaggregation)
  wrp_disagg_col <- ifelse(wrp_disagg_col == 0, wrp_geography_col, wrp_disagg_col)
  #cores <- detectCores()
  #cores <- ifelse(Sys.info()[["sysname"]] == "Windows", 1,
  #                min(c(cores, 2)))
  # Aggregate data using weights
  # if (geography == "country") {
  #   pos <- .pkgenv$wrp$wrp_disaggregations$pos[-length(.pkgenv$wrp$wrp_disaggregations$pos)]
  # }else {
  #   pos <- rev(.pkgenv$wrp$wrp_disaggregations$pos[-1])
  # }
  wrp_agg <- .pkgenv$wrp$wrp_data[, c(
    wrp_geography_col, wrp_disagg_col, .pkgenv$wrp$wrp_year_col, wrp_wgt_col,
    wrp_question_col
  )]
  names(wrp_agg)[4] <- "wgt"
  names(wrp_agg)[2] <- "group"
  if(get_label(wrp_agg$wp5) == get_label(wrp_agg$group)){
    set_label(wrp_agg$group) <- "Aggregate"
  }
  wrp_agg$disaggregation = ifelse(disaggregation == 0,  "Regional Aggregate", .pkgenv$wrp$wrp_disaggregations$label[.pkgenv$wrp$wrp_disaggregations$pos == wrp_disagg_col] )
  
  wrp_agg <- wrp_agg[!is.na(wrp_agg[, 5]), ] %>%
    wrp_aggregate() %>%
    wrp_clean()

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
