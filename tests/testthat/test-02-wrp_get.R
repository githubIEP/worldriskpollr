test_that("assess_wrp_get_region", {
  expected <- wrp_get(geography = "region", wrp_question_uid = "Q1", disaggregation = 0)
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_income", {
  expected <- wrp_get(geography = "income", wrp_question_uid = "Q1", disaggregation = 0)
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_world", {
  expected <- wrp_get(geography = "world", wrp_question_uid = "Q1", disaggregation = 0)
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_two_years", {
  expected <- wrp_get(geography = "country", wrp_question_uid = "Q1", disaggregation = 0)
  expect_s3_class(expected, "data.frame")
})


test_that("assess_wrp_get_one_year", {
  expected <- wrp_get(geography = "country", wrp_question_uid = "Q2_1", disaggregation = 0)
  expect_s3_class(expected, "data.frame")
})

test_that("assess_wrp_get_error_wrong_q_code", {
  expect_null(wrp_get(geography = "country", wrp_question_uid = "david", disaggregation = 0))
})

test_that("assess_wrp_get_error_wrong_geo_code", {
  expect_null(wrp_get(geography = "david", wrp_question_uid = "Q1", disaggregation = 0))
})

test_that("assess_wrp_get_error_wrong_dis_code", {
  expect_null(wrp_get(geography = "world", wrp_question_uid = "Q1", disaggregation = "david"))
})
