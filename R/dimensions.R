#' @rdname bypass-helpers
#' @export
.length <- function(x) {
  if (is.environment(x)) return(length(ls(x, all.names = TRUE)))
  length(unclass(x))
}

#' @rdname bypass-helpers
#' @export
.lengths <- function(x, use.names = TRUE) {
  .sapply(x, .length, USE.NAMES = use.names)
}

#' @rdname bypass-helpers
#' @export
.dim <- function(x) {
  attr(x, "dim")
}

#' @rdname bypass-helpers
#' @export
`.dim<-` <- function(x, value) {
  attr(x, "dim") <- value
  x
}

#' @rdname bypass-helpers
#' @export
.names <- function(x) {
  if (is.environment(x)) return(ls(x, all.names = TRUE, sorted = FALSE))
  names(unclass(x))
}

#' @rdname bypass-helpers
#' @export
`.names<-` <- function(x, value) {
  attr(x, "names") <- value
  x
}
