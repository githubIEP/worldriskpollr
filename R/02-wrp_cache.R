#' @title Download World Risk Poll data for this package if required.
#' @description Ensure that the optional data is available locally in the
#' package cache. Will try to download the data only if it is not available.
#' @importFrom utils download.file unzip
.wrp_cache <- function() {
  message("Downloading the World Risk Poll Data...\n")
  filename <- c("wrp.zip")
  url <- c("https://wrp.lrfoundation.org.uk/lrf_wrp_2021_full_data.zip")
  download.file(url, file.path(.wrp_package_folder(), filename), mode = "wb")
  unzip(file.path(.wrp_package_folder(), filename),
    exdir = file.path(.wrp_package_folder())
  )
  message("Processing the World Risk Poll...")
  .wrp_processing()
  files <- list.files(.wrp_package_folder(), full.names = TRUE)
  files <- files[!grepl(basename(.wrp_sysdata_file_path()), files)]
  file.remove(files)
  message("World Risk Poll is ready to use...")
}
