context("mr")

test_that("mr endpoint", {
  url <- getOption("epigraphdb.api.url")
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  r <- httr::RETRY("GET", glue::glue("{url}/mr"),
    query = list(
      exposure_trait = exposure,
      outcome_trait = outcome
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("mr mode = \"table\"", {
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  expect_error(
    df <- mr(
      exposure_trait = exposure,
      outcome_trait = outcome
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("mr mode = \"raw\"", {
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  expect_error(
    response <- mr(
      exposure_trait = exposure,
      outcome_trait = outcome,
      mode = "raw"
    ),
    NA
  )
  expect_equal(length(response), 2L)
})

test_that("mr parameters", {
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  expect_error(
    mr(
      exposure_trait = exposure,
      outcome_trait = NULL
    ),
    NA
  )
  expect_error(
    mr(
      exposure_trait = NULL,
      outcome_trait = outcome
    ),
    NA
  )
  expect_error(
    mr(
      exposure_trait = NULL,
      outcome_trait = NULL
    )
  )
})

test_that("mr pval_threshold", {
  exposure <- "Body mass index"
  expect_error(
    response <- mr(
      exposure_trait = exposure,
      pval_threshold = 1e-5
    ),
    NA
  )
  expect_error(
    response <- mr(
      exposure_trait = exposure,
      pval_threshold = 1e-8
    ),
    NA
  )
  expect_error(
    response <- mr(
      exposure_trait = exposure,
      pval_threshold = 1e-2
    ),
    NA
  )
})
