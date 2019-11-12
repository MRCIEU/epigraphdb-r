context("obs_cor")

test_that("obs_cor endpoint", {
  url <- getOption("epigraphdb.api.url")
  trait <- "body mass index"
  r <- httr::GET(glue::glue("{url}/obs_cor"),
    query = list(
      trait = trait
    )
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("obs_cor mode = \"table\"", {
  trait <- "body mass index"
  expect_error(
    df <- obs_cor(
      trait = trait
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("obs_cor mode = \"raw\"", {
  trait <- "body mass index"
  expect_error(
    response <- obs_cor(
      trait = trait,
      mode = "raw"
    ),
    NA
  )
  expect_equal(length(response), 2L)
})

test_that("obs_cor pval_threshold", {
  trait <- "Body mass index"
  expect_error(
    response <- obs_cor(
      trait = trait,
      pval_threshold = 1e-5
    ),
    NA
  )
  expect_error(
    response <- obs_cor(
      trait = trait,
      pval_threshold = 1e-8
    ),
    NA
  )
  expect_error(
    response <- obs_cor(
      trait = trait,
      pval_threshold = 1e-2
    ),
    NA
  )
})
