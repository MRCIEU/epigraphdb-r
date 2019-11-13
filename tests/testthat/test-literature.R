context("literature")

test_that("/literature/mr", {
  url <- getOption("epigraphdb.api.url")
  trait_name <- "Body mass index"
  semmed_predicate <- NULL
  r <- httr::GET(glue::glue("{url}/literature/mr"),
    query = list(
      trait_name = trait_name,
      semmed_predicate = semmed_predicate
    )
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("literature_mr", {
  trait_name <- "Body mass index"
  expect_error(
    literature_mr(
      trait_name = trait_name
    ),
    NA
  )
})
