#' Get the column number for the disaggregation
#'
#' @param wrp_disagg_col numeric reflecting which disaggregation has been
#' selected.
#'
#' @noRd

.get_disagg_column <- function(wrp_disagg_col) {
  if (!(wrp_disagg_col %in% 0:9)) {
    message("INPUT ERROR: `disaggregation` must be an 
            integer between 0 and 9.\nSee `?wrp_get` for help.")
    return(-1)
  }
  if (wrp_disagg_col > 0) {
    wrp_disagg_col <- .pkgenv$wrp$wrp_disaggregations$pos[wrp_disagg_col]
  }
  return(wrp_disagg_col)
}
