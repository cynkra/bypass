
#' @rdname bypass-helpers
#' @export
.dollar <- function(e1, e2) {
  .subset2(e1, as.character(substitute(e2)))
}

#' @rdname bypass-helpers
#' @export
`.subset1` <- function(x, ...) {
  cl <- class(x)
  x <- unclass(x)
  out <- x[...]
  class(out) <- cl
  out
}

#' @rdname bypass-helpers
#' @export
`.subset1<-` <- function(x, ..., value) {
  cl <- class(x)
  x <- unclass(x)
  x[...] <- value
  class(x) <- cl
  x
}

#' @rdname bypass-helpers
#' @export
`.subset2<-` <- function(x, ..., value) {
  cl <- class(x)
  x <- unclass(x)
  x[[...]] <- value
  class(x) <- cl
  x
}

#' @rdname bypass-helpers
#' @export
`.dollar<-` <- function(e1, e2, value) {
  .subset2(e1, as.character(substitute(e2))) <- value
  e1
}
