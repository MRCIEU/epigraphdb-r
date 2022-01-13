context("literature")

test_that("/literature/gwas", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  trait <- "Body mass index"
  semmed_predicate <- NULL
  r <- httr::RETRY("GET", glue::glue("{url}/literature/gwas"),
    query = list(
      trait = trait,
      semmed_predicate = semmed_predicate
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("literature_gwas", {
  skip_on_cran()
  trait <- "Body mass index"
  expect_error(
    literature_gwas(
      trait = trait
    ),
    NA
  )
})
