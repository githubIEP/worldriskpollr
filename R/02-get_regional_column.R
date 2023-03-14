#' Get the column number for the geography selected
#'
#' @param geography string, a demographic category by which to aggregate, needs
#' to be one of "country", "region", "income" or "world"
#' @noRd

.get_regional_column <- function(geography) {
  stopifnot(
    "`geography` must be either `country`, `region`, `income` or `world`" =
      is.character(match.arg(geography, choices =
                               .pkgenv$wrp$wrp_regions$WRP_UID))
  )
  geography <- .pkgenv$wrp$wrp_regions$pos[match(geography,
                                                 .pkgenv$wrp$wrp_regions$WRP_UID)]
  return(geography)
}
