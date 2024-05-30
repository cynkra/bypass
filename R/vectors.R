#' @rdname bypass-helpers
#' @export
.c <- function(...) base::c(NULL, ...)

#' @rdname bypass-helpers
#' @export
.unlist <- function(x, recursive = TRUE, use.names = TRUE) {
  unlist(unclass(x))
}

#' @rdname bypass-helpers
#' @export
.lapply <- function(X, FUN, ...) {
  lapply(unclass(X), FUN, ...)
}

#' @rdname bypass-helpers
#' @export
.sapply <- function (X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE) {
  sapply(unclass(X), FUN, ..., simplify = simplify, USE.NAMES = USE.NAMES)
}
