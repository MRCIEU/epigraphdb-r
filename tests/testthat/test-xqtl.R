context("xqtl")

test_that("/xqtl/multi-snp-mr", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  outcome_trait <- "Coronary heart disease"
  r <- httr::RETRY("GET", glue::glue("{url}/xqtl/multi-snp-mr"),
    query = list(
      outcome_trait = outcome_trait
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("/xqtl/single-snp-mr", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  outcome_trait <- "Coronary heart disease"
  r <- httr::RETRY("GET", glue::glue("{url}/xqtl/single-snp-mr"),
    query = list(
      outcome_trait = outcome_trait
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("xqtl_multi_snp_mr", {
  skip_on_cran()
  outcome_trait <- "Coronary heart disease"
  expect_error(
    xqtl_multi_snp_mr(
      outcome_trait = outcome_trait
    ),
    NA
  )
})

test_that("xqtl_single_snp_mr", {
  skip_on_cran()
  outcome_trait <- "Coronary heart disease"
  expect_error(
    xqtl_single_snp_mr(
      outcome_trait = outcome_trait
    ),
    NA
  )
})
