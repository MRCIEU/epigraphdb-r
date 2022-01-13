context("request_and_response")

test_that("query_epigraphdb raw", {
  skip_on_cran()
  expect_error(
    results <- query_epigraphdb(
      route = "/meta/nodes/Gwas/list",
      params = list(
        limit = 5,
        offset = 0
      )
    ),
    NA
  )
  expect_equal(names(results), c("metadata", "results"))
})

test_that("query_epigraphdb table", {
  skip_on_cran()
  expect_error(
    results <- query_epigraphdb(
      route = "/mr",
      params = list(
        exposure_trait = "Body mass index",
        outcome_trait = "Coronary heart disease"
      ),
      mode = "table"
    ),
    NA
  )
  expect_is(results, "tbl_df")
})

test_that("query_epigraphdb error handling", {
  skip_on_cran()
  expect_error(
    results <- query_epigraphdb(
      route = "/mr",
      params = list(
        exposure_trait = NULL,
        outcome_trait = NULL
      )
    )
  )
})

test_that("query_epigraphdb POST 1", {
  skip_on_cran()
  expect_error(
    results <- query_epigraphdb(
      route = "/protein/ppi",
      params = list(
        uniprot_id_list = c("P30793", "Q9NZM1", "O95236")
      ),
      method = "POST"
    ),
    NA
  )
  expect_equal(names(results), c("metadata", "results"))
})

test_that("query_epigraphdb POST 2", {
  skip_on_cran()
  expect_error(
    results <- query_epigraphdb(
      route = "/xqtl/single-snp-mr/gene-by-variant",
      params = list(
        qtl_type = "eQTL",
        variant_list = c(
          "rs7028268", "rs140244541", "rs4970834",
          "rs2904220", "rs34032254", "rs2184061", "rs7412",
          "rs11065979", "rs10774625", "rs4766578", "rs7568458",
          "rs10176176", "rs653178", "rs3184504", "rs3731827",
          "rs7310615", "rs10187424", "rs10774624", "rs17696736",
          "rs597808"
        )
      ),
      method = "POST",
      mode = "table"
    ),
    NA
  )
  expect_is(results, "tbl_df")
})
