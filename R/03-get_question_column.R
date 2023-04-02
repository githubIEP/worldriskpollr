#' Get the column number for the question
#'
#' @param wrp_question_uid string reflecting which question has been selected
#'
#' @noRd

.get_question_column <- function(wrp_question_uid) {
  if (!(wrp_question_uid %in% .pkgenv$wrp$wrp_questions$WRP_UID)) {
    message("INPUT ERROR: `wrp_question_uid` must be a valid World Risk Poll 
            question code.\nSee `?wrp_get` for help.\nFor the list of valid 
            question codes see ?wrp_search.")
    return(-1)
  }
  wrp_question_uid <- .pkgenv$wrp$wrp_questions$pos[match(
    wrp_question_uid,
    .pkgenv$wrp$wrp_questions$WRP_UID
  )]
  return(wrp_question_uid)
}
