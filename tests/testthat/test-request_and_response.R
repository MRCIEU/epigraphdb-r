context("request_and_response")

test_that("query_epigraphdb raw", {
  expect_error(
    results <- query_epigraphdb(
      route = "/meta/nodes/Gwas/list",
      params = list(
        limit = 5,
        offset = 0
      )
    ),
    NA
  )
  expect_equal(names(results), c("metadata", "results"))
})

test_that("query_epigraphdb table", {
  expect_error(
    results <- query_epigraphdb(
      route = "/mr",
      params = list(
        exposure_trait = "Body mass index",
        outcome_trait = "Coronary heart disease"
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
      route = "/mr",
      params = list(
        exposure_trait = NULL,
        outcome_trait = NULL
      )
    )
  )
})

test_that("query_epigraphdb POST", {
  expect_error(
    results <- query_epigraphdb(
      route = "/protein/ppi",
      params = list(
        uniprot_id_list = c("P30793", "Q9NZM1", "O95236")
      ),
      method = "POST"
    ),
    NA
  )
  expect_equal(names(results), c("metadata", "results"))
})
