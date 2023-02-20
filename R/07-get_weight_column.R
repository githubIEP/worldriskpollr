#' Get the column number for the weights
#'
#' @param wrp_geography_col numeric reflecting which regions have been selected
#' @param wrp, list, formatted World Risk Poll Questions
#'

.get_weight_column <- function(wrp_geography_col, wrp) {
  ifelse(wrp_geography_col == 1, wrp$wrp_weight_col, wrp$wrp_projweight_col)
}
