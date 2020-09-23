context("pathway")

test_that("/pathway", {
  url <- getOption("epigraphdb.api.url")
  trait <- "Body mass index"
  r <- httr::RETRY("GET", glue::glue("{url}/pathway"),
    query = list(
      trait = trait
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("pathway", {
  trait <- "Body mass index"
  expect_error(
    pathway(
      trait = trait
    ),
    NA
  )
})
