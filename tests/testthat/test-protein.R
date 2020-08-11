context("protein")

test_that("POST /protein/in-pathway", {
  url <- getOption("epigraphdb.api.url")
  uniprot_id_list <- c("014933", "060674", "P32455")
  params <- list(
    uniprot_id_list = uniprot_id_list
  )
  r <- httr::RETRY(
    "POST",
    glue::glue("{url}/protein/in-pathway"),
    body = jsonlite::toJSON(params, auto_unbox = TRUE),
    encode = "json",
    config = httr::add_headers(.headers = c("client-type" = "R"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("protein_in_pathway", {
  uniprot_id_list <- c("014933", "060674", "P32455")
  expect_error(
    df <- protein_in_pathway(
      uniprot_id_list = uniprot_id_list
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("protein_in_pathway, singleton", {
  uniprot_id_list <- c("014933")
  expect_error(
    df <- protein_in_pathway(
      uniprot_id_list = uniprot_id_list
    ),
    NA
  )
  expect_is(df, "tbl_df")
})
