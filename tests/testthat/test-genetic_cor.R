context("genetic_cor")

test_that("genetic_cor endpoint", {
  url <- getOption("epigraphdb.api.url")
  trait <- "body mass index"
  r <- httr::RETRY("GET", glue::glue("{url}/genetic-cor"),
    query = list(
      trait = trait
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("genetic_cor mode = \"table\"", {
  trait <- "body mass index"
  expect_error(
    df <- genetic_cor(
      trait = trait
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("genetic_cor mode = \"raw\"", {
  trait <- "body mass index"
  expect_error(
    response <- genetic_cor(
      trait = trait,
      mode = "raw"
    ),
    NA
  )
  expect_equal(length(response), 2L)
})

test_that("genetic_cor cor_coef_threshold", {
  trait <- "Body mass index"
  expect_error(
    response <- genetic_cor(
      trait = trait,
      cor_coef_threshold = 0.8
    ),
    NA
  )
  expect_error(
    response <- genetic_cor(
      trait = trait,
      cor_coef_threshold = 0.6
    ),
    NA
  )
  expect_error(
    response <- genetic_cor(
      trait = trait,
      cor_coef_threshold = 0.4
    ),
    NA
  )
})
