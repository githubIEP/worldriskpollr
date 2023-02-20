#' @title Delete all data in the package cache.
#'
#' @return integer. The return value of the unlink() call: 0 for success,
#' 1 for failure. See the unlink() documentation for details.
#'
#' @export
wrp_remove <- function() {
  file.remove(list.files(.wrp_package_folder(), full.names = TRUE))
}
