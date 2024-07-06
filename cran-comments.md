# epigraphdb 0.2.4

This is a minor update, removing several unused and non-runtime dependencies from the Imports and Suggests fields of the DESCRIPTION file.

# epigraphdb 0.2.3

(2022-01-14 second submission)
Fixed the issue of the package size too large.

(2022-01-14 first submissioin)
This is a minor update making the package building and checks more resilient to issues of internet resources.

- When a function call to web service resources fails, either because of the user or the service, it is now easier to trace the issue with more context provided.
- Vignettes are now pre-computed. Some vignettes involving lengthy analysis steps are moved to EpiGraphDB's documentation.
- When running package checks on cran, code examples of functions that rely on internet resources are put in `\dontrun{}`, and the same applies for unit tests (`skip_on_cran` in `testthat`).
  - Function code examples get run and checked when the pkgdown static site are built by GitHub Actions.
  - Tests (including ones relying on internet resources) get regularly run by GitHub Actions.

## Test environments
- Local Linux in Docker, R 4.1.2
- Via GitHub Actions
  - windows-latest, R release
  - macOS-latest, R release
  - ubuntu-20.04, R release and R devel
- Via rhub 
  - windows, R release and devel
  - Ubuntu Linux 20.04.1 LTS, R-release, GCC
  - Fedora Linux, R-devel, clang, gfortran
  - Fedora Linux, R-devel, clang, gfortran
