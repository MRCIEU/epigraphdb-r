.onAttach <- function(libname, pkgname) { # nolint
  packageStartupMessage("
    EpiGraphDB v0.3 (API: https://api.epigraphdb.org)
  ")
}

.onLoad <- function(libname, pkgname) { # nolint
  op <- options()
  op.epigraphdb <- list( # nolint
    epigraphdb.api.url = "https://api.epigraphdb.org"
  )
  toset <- !(names(op.epigraphdb) %in% names(op))
  if (any(toset)) options(op.epigraphdb[toset])

  invisible()
}
