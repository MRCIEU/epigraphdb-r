context("request_and_response")

test_that("query_epigraphdb raw", {
  expect_error(
    results <- query_epigraphdb(
      endpoint = "/meta/nodes/Gwas/list",
      params = list(
        limit = 5,
        offset = 0
      )
    ),
    NA
  )
  expect_equal(names(results), c("query", "results"))
})

test_that("query_epigraphdb table", {
  expect_error(
    results <- query_epigraphdb(
      endpoint = "/mr",
      params = list(
        exposure = "Body mass index",
        outcome = "Coronary heart disease"
      ),
      mode = "table"
    ),
    NA
  )
  expect_is(results, "tbl_df")
})

test_that("query_epigraphdb error handling", {
  expect_error(
    results <- query_epigraphdb(
      endpoint = "/mr",
      params = list(
        exposure = NULL,
        outcome = NULL
      )
    )
  )
})
