#' @title Download optional data for this package if required.
#'
#' @description Ensure that the optioanl data is available locally in the package cache. Will try to download the data only if it is not available.
#' 
#' @importFrom pkgfilecache get_pkg_info ensure_files_available get_filepath get_cache_dir remove_cached_files
#'
#' @return Named list. The list has entries: "available": vector of strings. The names of the files that are available in the local file cache. You can access them using get_optional_data_file(). "missing": vector of strings. The names of the files that this function was unable to retrieve.
#'

.wrp_cache <- function(pkg_info) {
  pkg_info = get_pkg_info("worldriskpollr");        # to identify the package using the cache
  # Replace these with your optional data files.
  message("Downloading the World Risk Poll Data...\n")
  filename = c("wrp.zip");    # How the files should be called in the local package file cache
  url = c("https://wrp.lrfoundation.org.uk/lrf_wrp_2021_full_data.zip"); # Remote URLs where to download files from
  #cfiles = ensure_files_available(pkg_info, filename, urls);
  download.file(url, file.path(get_cache_dir(pkg_info),filename), mode = "wb")
  unzip(file.path(get_cache_dir(pkg_info),filename), 
        exdir = get_cache_dir(pkg_info))
  message( "Processing the World Risk Poll...")
  .wrp_processing(pkg_info)
  files = list.files(get_cache_dir(pkg_info))
  files = files[!grepl(basename(.wrp_sysdata_file_path()), files)]
  remove_cached_files(pkg_info, files)
  message( "World Risk Poll is ready to use...")
}


