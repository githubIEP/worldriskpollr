#' @title Delete all data in the package cache.
#'
#' @return integer. The return value of the unlink() call: 0 for success, 1 for failure. See the unlink() documentation for details.
#'
#' @export
wrp_remove <- function() {
  pkg_info = pkgfilecache::get_pkg_info("worldriskpollr");
  return(pkgfilecache::erase_file_cache(pkg_info));
}