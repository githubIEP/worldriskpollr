#' Package cache for World Risk Poll data
#'
#' Caches the World Risk Poll data to your computer
#' @return folde rpath to data
#'

.wrp_package_folder <- function() {
  data_folder <- file.path(path.package("worldriskpollr"), "data")
  if (!dir.exists(data_folder)) {
    dir.create(data_folder)
  }
  return(data_folder)
}

#' Package cache for World Risk Poll data
#'
#' Caches the World Risk Poll data to your computer
#' @return file path to data
#'
.wrp_sysdata_file_path <- function() {
  # Set up data frame
  file_path <- file.path(.wrp_package_folder(), "sysdata.rda")
  return(file_path)
}