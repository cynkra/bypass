#' bypass helpers
#'
#' A collection of helpers that bypass the S3 dispatch of their internal
#' generic counterparts to fall back on the default behavior.
#'
#' Note that `.subset2()` is already defined in base R as
#' ways to bypass the S3 dispatch of `[[`. We implemented `.subset1()` however
#' as a version of `base::.subset()` that doesn't strip attributes.
#'
#' @param x,...,value,use.names,e1,e2,recursive,X,FUN,simplify,USE.NAMES Forwarded to internal generic counterparts
#' @name bypass-helpers
NULL

