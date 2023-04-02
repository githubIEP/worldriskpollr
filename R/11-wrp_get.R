#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param geography string, a demographic category by which to aggregate
#' @param wrp_question_uid string, the code for the survey
#' question to focus on
#' @param disaggregation integer within 0 to 9 (see details)
#'
#' @details The scope of the parameters for this function are
#' defined by the World Risk Poll data set.
#'
#' Entering parameters outside of the following will return an error message.
#'
#'
#' \itemize{
#'   \item \strong{geography}: Needs to be on of the following: "country", "region", "income", or "world".
#'   \item \strong{wrp_question_uid}: The code for the survey question to focus on, see \code{\link{wrp_search}}
#'   \item \strong{disaggregation}: The desired disaggregation is an integer between 0 and 9 to represent:
#'   \itemize{
#'    \item \strong{0: No disaggregation}: aggregates to the selected geography;
#'    \item \strong{1: Age group}: respondent's age group;
#'    \item \strong{2: Sex}: respondent's sex;
#'    \item \strong{3: Education}: respondent's highest level of education;
#'    \item \strong{4: Income Feelings}: respondent's feelings about their household income;
#'    \item \strong{5: Income Quintiles}: respondent's per capita income quintile;
#'    \item \strong{6: Employment}: respondent's employment Status
#'    \item \strong{7: Residence}: respondent's residence: urban or rural;
#'    \item \strong{8: Household Size}: total number of people in the respondent's household;
#'    \item \strong{9: Children in Household}: total number of children under 15 in the respondent's household.
#'   }
#'}
#'
#' @seealso \code{\link{wrp_search}}
#'
#' @importFrom dplyr group_by ungroup summarise bind_rows arrange
#' @importFrom stats complete.cases
#' @importFrom rlang .data env env_parent set_env
#' @importFrom sjlabelled get_label set_label set_label<-
#'
#' @return A data frame with aggregated World Risk Poll question data.
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
  if (wrp_geography_col < 0 ||
     wrp_question_col < 0 ||
     wrp_disagg_col < 0) {
    message("worldriskpollr existed, please try again")
    return(invisible(NULL))
  }
  wrp_agg <- .pkgenv$wrp$wrp_data[, c(
    wrp_geography_col, wrp_disagg_col, .pkgenv$wrp$wrp_year_col, wrp_wgt_col,
    wrp_question_col
  )]
  names(wrp_agg)[4] <- "wgt"
  names(wrp_agg)[2] <- "group"
  if (get_label(wrp_agg[, 1]) == get_label(wrp_agg$group)) {
    set_label(wrp_agg$group) <- "Aggregate"
  }
  wrp_agg$disaggregation <- ifelse(disaggregation == 0,
                                  "Regional Aggregate",
                                  .pkgenv$wrp$wrp_disaggregations$label[
                                    .pkgenv$wrp$wrp_disaggregations$pos ==
                                      wrp_disagg_col])

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
