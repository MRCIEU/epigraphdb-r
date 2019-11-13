context("confounder")

test_that("/confounder", {
  url <- getOption("epigraphdb.api.url")
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  r <- httr::GET(glue::glue("{url}/confounder"),
    query = list(
      exposure = exposure,
      outcome = outcome
    )
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("confounder", {
  exposure <- "Body mass index"
  outcome <- "Coronary heart disease"
  expect_error(
    confounder(
      exposure = exposure,
      outcome = outcome
    ),
    NA
  )
})
