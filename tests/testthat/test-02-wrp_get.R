test_that("assess_wrp_get_two_years", {
  expected <- wrp_get(geography = "country", wrp_question_uid = "Q1")
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_one_year", {
  expected <- wrp_get(geography = "country", wrp_question_uid = "Q2_1")
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_error_wrong_q_code", {
  expect_error(wrp_get(geography = "country", wrp_question_uid = "david"))
})

test_that("assess_wrp_get_error_wrong_geo_code", {
  expect_error(wrp_get(geography = "david", wrp_question_uid = "Q1"))
})
