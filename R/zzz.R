#' @importFrom utils download.file unzip
#' @importFrom httr HEAD
#' @importFrom curl has_internet

.onLoad <- function(lib, pkg) {
  test <- has_internet()
  stopifnot("\nNo internet connection detected.\n...You need an active internet connection to use `worldriskpollr`.\n...Once connected, reload the package with `library(worldriskpollr)`" =
              test)
  url <- "https://github.com/githubIEP/worldriskpollr/raw/master/data-raw/sysdata073.rda"
  url_exists <- HEAD(url)
  stopifnot("\nWorld Risk Poll file not found.\n...Please contact the package maintainer." =
              (url_exists$status_code == 200))
  temp <- tempfile()
  dl <- suppressWarnings(try(download.file(url, temp, mode = "wb",
                                           quiet = TRUE), silent = TRUE))
  stopifnot("\nWorld Risk Poll download timed-out.\n...Please check your internet connection and reload the package with\n`library(worldriskpollr)`" =
              class(dl) != "try-error")
  .pkgenv$wrp <- readRDS(temp)
  unlink(temp)
}
