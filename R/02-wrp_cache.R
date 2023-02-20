#' @title Download World Risk Poll data for this package if required.
#' @description Ensure that the optional data is available locally in the
#' package cache. Will try to download the data only if it is not available.
#' @importFrom utils download.file unzip
.wrp_cache <- function() {
  message("Downloading the World Risk Poll Data...\n")
  filename <- "sysdata.rda"
  url <- c("https://github.com/githubIEP/worldriskpollr/raw/master/data-raw/sysdata.rda")
  download.file(url, file.path(.wrp_package_folder(), filename), mode = "wb")
  message("World Risk Poll is ready to use...")
}
