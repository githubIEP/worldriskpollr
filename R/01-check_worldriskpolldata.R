#' Check whether to install rnaturalearthhires and install if necessary
#'
#' If the rnaturalearthhires package is not installed, install it from GitHub
#' using devtools. If it is not up to date, reinstall it.
#' 
#' @importFrom devtools install_github
#' @importFrom utils menu
#'
check_worldriskpolldata <- function() {
  if (!requireNamespace("worldriskpolldata", quietly = TRUE)) {
    message("The worldriskpolldata package needs to be installed.")
    install_worldriskpolldata()
  } 
}

#' Install the naturalearthhires package after checking with the user
#' @export
install_worldriskpolldata <- function() {
  instructions <- paste(
    " Please try installing the package for yourself",
    "using the following command: \n",
    "    devtools::install_github(\"githubIEP/worldriskpolldata\")"
  )
  
  if (interactive()) {
    input <- utils::menu(c("Yes", "No"),
                         title = "Install the worldriskpolldata package?"
    )
  }
  error_func <- function(e) {
    stop(
      paste("Failed to install the worldriskpolldata package.\n", instructions)
    )
  }
  
  if (input == 1) {
    message("Installing the worldriskpolldata package.")
    tryCatch(
      devtools::install_github("githubIEP/worldriskpolldata"),
      error = error_func, warning = error_func
    )
  } else {
    stop(paste(
      "The githubIEP/worldriskpolldata package is necessary for that method.\n",
      instructions
    ))
  }
}
