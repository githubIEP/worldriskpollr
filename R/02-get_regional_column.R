#' Get the column number for the geography selected
#'
#' @param geography string, a demographic category by which to aggregate, needs
#' to be one of "country", "region", "income" or "world"
#' @noRd

.get_regional_column <- function(geography) {
  if (!(geography %in% .pkgenv$wrp$wrp_regions$WRP_UID)) {
    message("INPUT ERROR: `geography` must be either `country`, `region`, 
            `income` or `world`.\nSee `?wrp_get` for help.")
    return(-1)
  }
  geography <- .pkgenv$wrp$wrp_regions$pos[match(geography,
                                                 .pkgenv$wrp$wrp_regions$WRP_UID)]
  return(geography)
}
