test_that("assess_wrp_get", {
  expected <- wrp_get(geography = "country", question = 10)
  expect_s3_class(expected, "data.frame")
})
