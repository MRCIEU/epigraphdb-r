context("meta")

test_that("GET /meta/nodes/list", {
  url <- getOption("epigraphdb.api.url")
  route <- "/meta/nodes/list"
  r <- httr::RETRY("GET", url=glue::glue("{url}{route}"))
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("GET /meta/rels/list", {
  url <- getOption("epigraphdb.api.url")
  route <- "/meta/rels/list"
  r <- httr::RETRY("GET", url=glue::glue("{url}{route}"))
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("GET /meta/nodes/{meta_node}/list", {
  url <- getOption("epigraphdb.api.url")
  route <- "/meta/nodes/list"
  r <- httr::RETRY("GET", url=glue::glue("{url}{route}"))
  meta_nodes <- unlist(httr::content(r))
  meta_nodes %>% purrr::walk(function(meta_node) {
    route <- glue::glue("/meta/nodes/{meta_node}/list")
    r <- httr::RETRY("GET", url=glue::glue("{url}{route}"))
    expect_equal(httr::status_code(r), 200)
    expect_true(length(httr::content(r)) > 0)
  })
})

test_that("GET /meta/rels/{meta_rel}/list", {
  url <- getOption("epigraphdb.api.url")
  route <- "/meta/rels/list"
  r <- httr::RETRY("GET", url=glue::glue("{url}{route}"))
  meta_rels <- unlist(httr::content(r))
  meta_rels %>% purrr::walk(function(meta_rel) {
    route <- glue::glue("/meta/rels/{meta_rel}/list")
    r <- httr::RETRY("GET", url=glue::glue("{url}{route}"))
    expect_equal(httr::status_code(r), 200)
    expect_true(length(httr::content(r)) > 0)
  })
})

test_that("meta_nodes_list", {
  expect_error(
    meta_nodes_list(),
    NA
  )
})

test_that("meta_rels_list", {
  expect_error(
    meta_rels_list(),
    NA
  )
})

test_that("meta_nodes_list_node", {
  meta_node <- "Gwas"
  expect_error(
    meta_nodes_list_node(
      meta_node = meta_node
    ),
    NA
  )
})

test_that("meta_rels_list_rel", {
  meta_rel <- "MR"
  expect_error(
    meta_rels_list_rel(
      meta_rel = meta_rel
    ),
    NA
  )
})

test_that("meta_nodes_search_node, by id", {
  meta_node <- "Gwas"
  id <- "ieu-a-2"
  expect_error(
    meta_nodes_search_node(
      meta_node = meta_node,
      id = id
    ),
    NA
  )
})

test_that("meta_nodes_search_node, by name", {
  meta_node <- "Gwas"
  name <- "Body mass index"
  expect_error(
    meta_nodes_search_node(
      meta_node = meta_node,
      name = name
    ),
    NA
  )
})
