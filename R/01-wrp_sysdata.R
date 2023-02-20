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
#' @importFrom pkgfilecache get_pkg_info ensure_files_available get_filepath get_cache_dir
#'
#' @return data frame with aggregated World Risk Poll question data
#'
#' @examples wrp_get(geography = "country", wrp_question_uid = "Q1")


.wrp_sysdata_file_path <- function() {
  # Set up data frame
  pkg_info = get_pkg_info("worldriskpollr");
  file_path = file.path(get_cache_dir(pkg_info), "sysdata.rdata")
  return(file_path)
}
