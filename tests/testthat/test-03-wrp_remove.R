test_that("test_removal", {
  wrp_remove()
  expected <- wrp_get(geography = "country", wrp_question_uid = "Q1")
  expect_s3_class(expected, "data.frame")
})
