context("protein")

test_that("POST /mappings/gene-to-protein", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  gene_name_list <- c("GCH1", "MYOF")
  params <- list(
    gene_name_list = I(gene_name_list)
  )
  r <- httr::RETRY(
    "POST",
    glue::glue("{url}/mappings/gene-to-protein"),
    body = jsonlite::toJSON(params, auto_unbox = TRUE),
    encode = "json",
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("mappings_gene_to_protein, by gene name", {
  skip_on_cran()
  gene_name_list <- c("GCH1", "MYOF")
  expect_error(
    df <- mappings_gene_to_protein(
      gene_name_list = gene_name_list
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("mappings_gene_to_protein, by gene name, singleton", {
  skip_on_cran()
  gene_name_list <- c("GCH1")
  expect_error(
    df <- mappings_gene_to_protein(
      gene_name_list = gene_name_list
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("mappings_gene_to_protein, by gene id", {
  skip_on_cran()
  gene_id_list <- c("ENSG00000162594", "ENSG00000113302")
  expect_error(
    df <- mappings_gene_to_protein(
      gene_id_list = gene_id_list,
      by_gene_id = TRUE
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("mappings_gene_to_protein, by gene id, singleton", {
  skip_on_cran()
  gene_id_list <- c("ENSG00000162594")
  expect_error(
    df <- mappings_gene_to_protein(
      gene_id_list = gene_id_list,
      by_gene_id = TRUE
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("mappings_gene_to_protein, error handling", {
  skip_on_cran()
  gene_id_list <- c("ENSG00000162594")
  expect_error(
    df <- mappings_gene_to_protein(
      gene_id_list = gene_id_list,
      by_gene_id = FALSE
    )
  )
})
