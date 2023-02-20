#' Get the column number for the geography selected
#'
#' @param geography string, a demographic category by which to aggregate, needs
#' to be one of "country", "region" or "income"
#'

.get_regional_column <- function(geography = wrp$wrp_regions$WRP_UID) {
  stopifnot(
    "`geography` must be either `country` or `region`" =
      is.character(match.arg(geography))
  )
  geography <- wrp$wrp_regions$pos[match(geography, wrp$wrp_regions$WRP_UID)]
  return(geography)
}
