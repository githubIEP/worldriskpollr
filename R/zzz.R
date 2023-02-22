.onLoad <- function(lib, pkg) {
  url <- "https://github.com/githubIEP/worldriskpollr/raw/master/data-raw/sysdata.rda"
  temp <- tempfile()
  dl <- suppressWarnings(try(download.file(url, temp, mode = 'wb', quiet = TRUE),silent = TRUE))
  stopifnot("You need an active internet connection to use `worldriskpollr`" = class(dl) != "try-error")
  .pkgenv$wrp <- readRDS(temp)
  unlink(temp)
 }