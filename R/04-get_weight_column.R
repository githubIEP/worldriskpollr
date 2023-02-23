#' Get the column number for the weights
#'
#' @param wrp_geography_col numeric reflecting which regions have been selected
#'
#' @noRd

.get_weight_column <- function(wrp_geography_col) {
  ifelse(wrp_geography_col == 1, .pkgenv$wrp$wrp_weight_col,
         .pkgenv$wrp$wrp_projweight_col)
}
