
#' @rdname bypass-helpers
#' @export
.dollar <- function(e1, e2) {
  .subset2(e1, as.character(substitute(e2)))
}

#' @rdname bypass-helpers
#' @export
`.subset<-` <- function(x, ..., value) {
  local_bypass0("[<-", oldClass(x))
  x[...] <- value
  x
}

#' @rdname bypass-helpers
#' @export
`.subset2<-` <- function(x, ..., value) {
  local_bypass0("[[<-", oldClass(x))
  x[[...]] <- value
  x
}

#' @rdname bypass-helpers
#' @export
`.dollar<-` <- function(e1, e2, value) {
  .subset2(e1, as.character(substitute(e2))) <- value
  e1
}
