context("pathway")

test_that("/pathway", {
  url <- getOption("epigraphdb.api.url")
  trait_name <- "Body mass index"
  r <- httr::GET(glue::glue("{url}/pathway"),
    query = list(
      trait_name = trait_name
    )
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("pathway", {
  trait_name <- "Body mass index"
  expect_error(
    pathway(
      trait_name = trait_name
    ),
    NA
  )
})
