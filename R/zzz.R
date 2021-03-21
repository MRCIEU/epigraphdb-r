.onAttach <- function(libname, pkgname) { # nolint
  packageStartupMessage("
    EpiGraphDB v1.0 (API: https://api.epigraphdb.org)
  ")
}

.onLoad <- function(libname, pkgname) { # nolint
  current_options <- options()
  package_options <- list(
    # URL to EpiGraphDB API
    epigraphdb.api.url = "https://api.epigraphdb.org",
    # Are the requests for CI usage
    epigraphdb.ci = Sys.getenv(x = "CI", unset = c(CI = "false")) %>%
      as.logical()
  )
  to_set <- !(names(package_options) %in% names(current_options))
  if (any(to_set)) options(package_options[to_set])

  invisible()
}
