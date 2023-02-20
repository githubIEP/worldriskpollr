#' Get the column number for the question
#'
#' @param question_uid numeric reflecting which question has been selected
#'

.get_question_column <- function(question_uid = wrp_questions$WRP_UID) {
  stopifnot(
    "`question_uid` must be a valid World Risk Poll question code" =
      is.character(match.arg(question_uid))
  )
  question_uid <- wrp_questions$pos[match(question_uid, wrp_questions$WRP_UID)]
  return(question_uid)
}
