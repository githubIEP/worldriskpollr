#' @importFrom utils download.file unzip
#' @importFrom httr HEAD
#' @importFrom curl has_internet

.onLoad <- function(lib, pkg) {
  options(timeout = 10000)
  test <- has_internet()
  stopifnot("No internet connection detected. You need an active internet connection to use `worldriskpollr`.\nOnce connected, reload the package with `library(worldriskpollr)`" =
              test)
  url <- "https://github.com/githubIEP/worldriskpollr/raw/master/data-raw/sysdata.rda"
  url_exists <- HEAD(url)
  stopifnot("World Risk Poll file not found. Please contact the package maintainer." =
              (url_exists$status_code == 200))
  temp <- tempfile()
  dl <- suppressWarnings(try(download.file(url, temp, mode = "wb",
                                           quiet = TRUE), silent = TRUE))
  stopifnot("World Risk Poll download timed-out.\nPlease check your internet connection and reload the package with `library(worldriskpollr)`" =
              class(dl) != "try-error")
  .pkgenv$wrp <- readRDS(temp)
  unlink(temp)
}
