context("obs_cor")

test_that("obs_cor endpoint", {
  url <- getOption("epigraphdb.api.url")
  trait <- "body mass index"
  r <- httr::RETRY("GET", glue::glue("{url}/obs-cor"),
    query = list(
      trait = trait
    )
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
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

test_that("obs_cor cor_coef_threshold", {
  trait <- "Body mass index"
  expect_error(
    response <- obs_cor(
      trait = trait,
      cor_coef_threshold = 0.8
    ),
    NA
  )
  expect_error(
    response <- obs_cor(
      trait = trait,
      cor_coef_threshold = 0.6
    ),
    NA
  )
  expect_error(
    response <- obs_cor(
      trait = trait,
      cor_coef_threshold = 0.4
    ),
    NA
  )
})
