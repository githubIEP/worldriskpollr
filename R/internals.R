.get_regional_column = function(geography = wrp_regions$WRP_UID){
  stopifnot("`geography` must be either `country`, `regions` or `income`" = 
              is.character(match.arg(geography)))
  geography <- wrp_regions$pos[match(geography, wrp_regions$WRP_UID)]
  return(geography)
}

.get_question_column = function(question_uid = wrp_questions$WRP_UID){
  stopifnot("`question_uid` must be a valid World Risk Poll question code" = 
              is.character(match.arg(question_uid)))
  question_uid <- wrp_questions$pos[match(question_uid, wrp_questions$WRP_UID)]
  return(question_uid)
}

.get_weight_column = function(wrp_geography_col){
  ifelse(wrp_geography_col == 2, wrp_weight_col, wrp_projweight_col)
}

.print_question_summary = function(question_summary){
  if(nrow(question_summary) == 2){
    .print_two_year_summary(question_summary)
  }else{
    .print_one_year_summary(question_summary)
  }
}

.print_two_year_summary = function(question_summary){
  
  message(paste("This questions was asked in", paste(question_summary$year, collapse = " and ")))
  for (i in 1:nrow(question_summary)){
    message(paste("In", question_summary$year[i], "it was asked in", question_summary$n[i], "regions"))
  }

}

.print_one_year_summary = function(question_summary){
  message(paste("This questions was only asked in", question_summary$year))
  for (i in 1:nrow(question_summary)){
    message(paste("In", question_summary$year[i], "it was asked in", question_summary$n[i], "of the selected geographies"))
  }
}