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
#' @importFrom rlang .data env env_parent set_env
#' @importFrom pkgfilecache get_pkg_info ensure_files_available get_filepath get_cache_dir
#'
#' @return data frame with aggregated World Risk Poll question data
#'
#' @examples wrp_get(geography = "country", wrp_question_uid = "Q1")


.wrp_check <- function() {
  # Set up data frame
  pkg_info = get_pkg_info("worldriskpollr");
  if(!file.exists(.wrp_sysdata_file_path())){
   .wrp_cache(pkg_info) 
  }
  f2 <- function(envir = parent.frame()) {
    load(.wrp_sysdata_file_path())
    environment()
  }
  return(f2())
}
