## Resubmission (2020-08-19)

In this resubmission I have made the following changes:

- Fixed the formatting of DESCRIPTION in accordance with CRAN policies
- I disabled live changes of options in runtime in the examples (the code block is now static)
- Fixed a few minor issues in package dependency and urls as identified by checks.

NOTE that when building the package it is plausible (though very rare) that the issue "Examples with CPU (user + system) or elapsed time > 10s" could occur randomly.
This is usually caused by network issues and the package attempts to resend requests to the API service.
This issue should be safely ignored as its occurrence is usually random and rare.

## Test environments
* local macOS install, R 3.6.1
* local GNU/Linux (Manjaro Linux) install, R 4.0.2
* ubuntu 14.04 (on travis-ci), R release
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a new release.
