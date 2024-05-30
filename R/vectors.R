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
  # same code as sapply, except we use .lapply
  FUN <- match.fun(FUN)
  answer <- .lapply(X = X, FUN = FUN, ...)
  if (USE.NAMES && is.character(X) && is.null(names(answer)))
    names(answer) <- X
  if (!isFALSE(simplify))
    simplify2array(answer, higher = (simplify == "array"))
  else answer
}
