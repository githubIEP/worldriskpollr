test_that("assess_wrp_get_two_years", {
  # for(geo in wrp_regions$WRP_UID){
  #   for (q in wrp_questions$WRP_UID){
  #     expected <- wrp_get(geography = geo, wrp_question_uid = sample(wrp_questions$WRP_UID, q))
  #     expect_s3_class(expected, "data.frame")
  #   }
  # }
  expected <- wrp_get(geography = "country", wrp_question_uid = "Q1")
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_one_year", {
  # for(geo in wrp_regions$WRP_UID){
  #   for (q in wrp_questions$WRP_UID){
  #     expected <- wrp_get(geography = geo, wrp_question_uid = sample(wrp_questions$WRP_UID, q))
  #     expect_s3_class(expected, "data.frame")
  #   }
  # }
  expected <- wrp_get(geography = "country", wrp_question_uid = "Q2_1")
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_error_wrong_q_code", {
  # for(geo in wrp_regions$WRP_UID){
  #   for (q in wrp_questions$WRP_UID){
  #     expected <- wrp_get(geography = geo, wrp_question_uid = sample(wrp_questions$WRP_UID, q))
  #     expect_s3_class(expected, "data.frame")
  #   }
  # }
  expect_error(wrp_get(geography = "country", wrp_question_uid = "david"))
})

test_that("assess_wrp_get_error_wrong_geo_code", {
  # for(geo in wrp_regions$WRP_UID){
  #   for (q in wrp_questions$WRP_UID){
  #     expected <- wrp_get(geography = geo, wrp_question_uid = sample(wrp_questions$WRP_UID, q))
  #     expect_s3_class(expected, "data.frame")
  #   }
  # }
  expect_error(wrp_get(geography = "david", wrp_question_uid = "Q1"))
})