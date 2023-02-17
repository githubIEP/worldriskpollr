test_that("search works", {
  expected <- wrp_search(string = "violence")
  expect_s3_class(expected, "data.frame")
})

test_that("search doesn't work", {
  expected <- wrp_search(string = "david")
  expect_null(expected)
})
