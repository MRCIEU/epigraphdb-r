context("literature")

test_that("/literature/gwas", {
  url <- getOption("epigraphdb.api.url")
  trait <- "Body mass index"
  semmed_predicate <- NULL
  r <- httr::GET(glue::glue("{url}/literature/gwas"),
    query = list(
      trait = trait,
      semmed_predicate = semmed_predicate
    )
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("literature_gwas", {
  trait <- "Body mass index"
  expect_error(
    literature_gwas(
      trait = trait
    ),
    NA
  )
})
