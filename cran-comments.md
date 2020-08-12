## Resubmission (2020-08-12)

In this resubmission I have made the following changes:

- All functions that involve calling API queries now conformed with
  the retry mechanism which try to reduce chances of
  functions returning errors due to network issues.

NOTE: a side effect is random occurrence of
"Examples with CPU (user + system) or elapsed time > 10s"
issues. These are due to network issues and should be ignored.

## Resubmission (2020-08-11)

In this resubmission I have made the following changes:

1. Fixed several broken urls that were identified from last submission.
2. A few errors from last submission were related to network issues, so I added
   a retry mechanism for API calls and it should reduce the chances
   of errors due to network issues.

Please note that it is likely that some tests will take longer time to finish and
the checks will give **NOTE**s to these issues.
These NOTEs can be safely ignored as they simply mean those functions are retrying
API calls.

## Resubmission (2020-08-07)

In this resubmission I have made the following changes:

- Updated DESCRIPTION to conform with CRAN policies (checked with a local rhub environment `rhub::local_check_linux()`).
- Updated the URL link of a CRAN package.
- Fixed a few other minor issues identified by rhub's local check `rhub::local_check_linux()`.

## Test environments
* local macOS install, R 3.6.1
* local GNU/Linux (Manjaro Linux) install, R 4.0.2
* ubuntu 14.04 (on travis-ci), R release
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a new release.
