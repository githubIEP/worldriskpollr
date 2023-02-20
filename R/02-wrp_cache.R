#' @title Download World Risk Poll data for this package if required.
#' @description Ensure that the optional data is available locally in the
#' package cache. Will try to download the data only if it is not available.
#' @param pkg_info Package info from pkgfilecache
#' @importFrom pkgfilecache get_pkg_info ensure_files_available get_filepath
#' get_cache_dir remove_cached_files
#' @importFrom utils download.file unzip
.wrp_cache <- function(pkg_info) {
  pkg_info <- get_pkg_info("worldriskpollr")
  message("Downloading the World Risk Poll Data...\n")
  filename <- c("wrp.zip")
  url <- c("https://github.com/githubIEP/worldriskpollr/blob/master/data-raw/wrp.zip")
  download.file(url, file.path(get_cache_dir(pkg_info), filename), mode = "wb")
  unzip(file.path(get_cache_dir(pkg_info), filename),
    exdir = get_cache_dir(pkg_info)
  )
  message("Processing the World Risk Poll...")
  .wrp_processing(pkg_info)
  files <- list.files(get_cache_dir(pkg_info))
  files <- files[!grepl(basename(.wrp_sysdata_file_path()), files)]
  remove_cached_files(pkg_info, files)
  message("World Risk Poll is ready to use...")
}
