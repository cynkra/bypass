#' @rdname bypass-helpers
#' @export
.c <- function(...) base::c(NULL, ...)

#' @rdname bypass-helpers
#' @export
.unlist <- function(x, recursive = TRUE, use.names = TRUE) {
  local_bypass("unlist", oldClass(x))
  unlist(x)
}

#' @rdname bypass-helpers
#' @export
.lapply <- function(X, FUN, ...) {
  # for ignores class, so we don't need to copy
  # so should be more efficient than lapply(unclass(x), FUN, ...)
  len <- .length(X)
  out <- vector("list", len)
  for (i in seq_len(len)) {
    out[[i]] <- FUN(.subset2(X, i), ...)
  }
  .names(out) <- .names(X)
  out
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
