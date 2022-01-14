context("ontology")

test_that("ontology endpoint", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  efo_term <- "blood pressure"
  r <- httr::RETRY("GET", glue::glue("{url}/ontology/gwas-efo"),
    query = list(
      efo_term = efo_term
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("ontology mode = \"table\"", {
  skip_on_cran()
  efo_term <- "blood pressure"
  expect_error(
    df <- ontology_gwas_efo(
      efo_term = efo_term
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("mr mode = \"raw\"", {
  skip_on_cran()
  efo_term <- "blood pressure"
  expect_error(
    response <- ontology_gwas_efo(
      efo_term = efo_term,
      mode = "raw"
    ),
    NA
  )
  expect_equal(length(response), 2L)
})
