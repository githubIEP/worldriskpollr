#' Get the column number for the question
#'
#' @param wrp_question_uid numeric reflecting which question has been selected
#'

.get_question_column <- function(wrp_question_uid) {
  stopifnot(
    "`wrp_question_uid` must be a valid World Risk Poll question code" =
      is.character(match.arg(wrp_question_uid,
        choices = .pkgenv$wrp$wrp_questions$WRP_UID
      ))
  )
  wrp_question_uid <- .pkgenv$wrp$wrp_questions$pos[match(
    wrp_question_uid,
    .pkgenv$wrp$wrp_questions$WRP_UID
  )]
  return(wrp_question_uid)
}
