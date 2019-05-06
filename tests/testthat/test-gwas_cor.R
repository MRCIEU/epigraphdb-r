context("gwas_cor")

test_that("gwas_cor endpoint", {
  url <- getOption("epigraphdb.api.url")
  trait <- "body mass index"
  r <- httr::GET(glue::glue("{url}/gwas_cor"),
    query = list(
      trait = trait
    )
  )
  expect_equal(r$status_code, 200)
})

test_that("gwas_cor mode = \"table\"", {
  trait <- "body mass index"
  expect_error(
    df <- gwas_cor(
      trait = trait
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("gwas_cor mode = \"raw\"", {
  trait <- "body mass index"
  expect_error(
    response <- gwas_cor(
      trait = trait,
      mode = "raw"
    ),
    NA
  )
  expect_equal(length(response), 2L)
})
