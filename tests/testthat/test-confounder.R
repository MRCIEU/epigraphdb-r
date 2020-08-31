context("confounder")

test_that("/confounder", {
  url <- getOption("epigraphdb.api.url")
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  r <- httr::RETRY("GET", glue::glue("{url}/confounder"),
    query = list(
      exposure_trait = exposure,
      outcome_trait = outcome
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("confounder", {
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  expect_error(
    confounder(
      exposure_trait = exposure,
      outcome_trait = outcome
    ),
    NA
  )
})
