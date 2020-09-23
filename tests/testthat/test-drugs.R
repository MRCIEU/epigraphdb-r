context("drugs")

test_that("/drugs/risk-factors", {
  url <- getOption("epigraphdb.api.url")
  trait <- "Body mass index"
  r <- httr::RETRY("GET", glue::glue("{url}/drugs/risk-factors"),
    query = list(
      trait = trait
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("drugs_risk_factors", {
  trait <- "Body mass index"
  expect_error(
    drugs_risk_factors(
      trait = trait
    ),
    NA
  )
})
