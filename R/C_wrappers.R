#' @rdname bypass-helpers
#' @export
.length <- function(x) {
  .Call("true_length", PACKAGE = "bypass", x)
}
