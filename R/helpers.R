#' bypass helpers
#'
#' A collection of helpers that bypass the S3 dispatch of their internal
#' generic counterparts to fall back on the default behavior.
#'
#' Note that `.subset()` and `.subset2()` are already defined in base R as
#' ways to bypass the S3 dispatch of `[` and `[[`.
#'
#' @param x,...,value Forwarded to internal generic counterparts
#' @name bypass-helpers
NULL

