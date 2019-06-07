context("mr")

test_that("mr endpoint", {
  url <- getOption("epigraphdb.api.url")
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  r <- httr::GET(glue::glue("{url}/mr"),
    query = list(
      exposure = exposure,
      outcome = outcome
    )
  )
  expect_equal(r$status_code, 200)
})

test_that("mr mode = \"table\"", {
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  expect_error(
    df <- mr(
      exposure = exposure,
      outcome = outcome
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
      exposure = exposure,
      outcome = outcome,
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
      exposure = exposure,
      outcome = NULL
    ),
    NA
  )
  expect_error(
    mr(
      exposure = NULL,
      outcome = outcome
    ),
    NA
  )
  expect_error(
    mr(
      exposure = NULL,
      outcome = NULL
    ),
    "exposure and outcome cannot be both NULL!"
  )
})

test_that("mr pval_threshold", {
  exposure <- "Body mass index"
  expect_error(
    response <- mr(
      exposure = exposure,
      pval_threshold = 1e-5
    ),
    NA
  )
  expect_error(
    response <- mr(
      exposure = exposure,
      pval_threshold = 1e-8
    ),
    NA
  )
  expect_error(
    response <- mr(
      exposure = exposure,
      pval_threshold = 1e-2
    ),
    NA
  )
})
