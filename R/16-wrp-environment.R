#' Get aggregated data for a question in the World Risk Poll
#'
#' Allows you to access aggregated data for a World Risk Poll question.
#'
#' @param envir environment of all processed World Risk Poll data
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


.wrp_env <- function(envir = parent.frame()) {
    
    environment()
}

