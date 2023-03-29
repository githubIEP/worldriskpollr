#' Get the column number for the weights
#'
#' @param wrp_geography_col numeric reflecting which regions have been selected
#'
#' @noRd

.get_disagg_column <- function(wrp_disagg_col) {
  stopifnot(
    "`disaggregation` must be an integer between 0 and 9. See `?wrp_get` for help" =
      is.character(match.arg(as.character(wrp_disagg_col), 
                             choices = as.character(0:nrow(.pkgenv$wrp$wrp_disaggregations))))
  )
 if(wrp_disagg_col > 0){
   wrp_disagg_col =.pkgenv$wrp$wrp_disaggregations$pos[wrp_disagg_col]
 }
  return(wrp_disagg_col)
}
