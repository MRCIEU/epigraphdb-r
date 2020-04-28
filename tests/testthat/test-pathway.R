context("pathway")

test_that("/pathway", {
  url <- getOption("epigraphdb.api.url")
  trait <- "Body mass index"
  r <- httr::GET(glue::glue("{url}/pathway"),
    query = list(
      trait = trait
    )
  )
  expect_equal(httr::status_code(r), 200)
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
