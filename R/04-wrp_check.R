#' Check World Risk Poll Data has previously been cached
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#'
#' @importFrom dplyr group_by ungroup summarise bind_rows arrange
#' @importFrom utils menu
#' @importFrom stats complete.cases
#' @importFrom rlang .data env env_parent set_env
#' @importFrom pkgfilecache get_pkg_info ensure_files_available get_filepath
#' get_cache_dir
#'
#' @return data frame with aggregated World Risk Poll question data
#'
#' @examples wrp_get(geography = "country", wrp_question_uid = "Q1")
.wrp_check <- function() {
  # Set up data frame
  pkg_info <- get_pkg_info("worldriskpollr")
  if (!file.exists(.wrp_sysdata_file_path())) {
    .wrp_cache(pkg_info)
  }
  wrp <- readRDS(.wrp_sysdata_file_path())
  return(wrp)
}
