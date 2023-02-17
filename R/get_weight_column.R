#' Get the column number for the weights
#'
#' @param wrp_geography_col numeric reflecting which regions have been selected
#'

.get_weight_column <- function(wrp_geography_col) {
  ifelse(wrp_geography_col == 1, wrp_weight_col, wrp_projweight_col)
}
