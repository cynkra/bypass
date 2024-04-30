#' Bypass S3 Methods
#'
#' * `with_bypass()` evaluates `expr` without triggering the S3 methods for
#' the given fun and class
#' * `with_bypasses()` evaluates `expr` without triggering S3 methods for some curated
#'  internal generics (see details)
#' * `local_bypass()` and `local_bypasses()` set up a function not to trigger these S3 methods from the
#'   function's code
#'
#' `with_bypasses()` and `local_bypasses()` override
#' `c`, `dim`, `dim<-`, `$`, `$<-`, `lapply`, `length`, `lengths`, `names`,
#' `names<-`, `sapply`, `[`, `[[`, `[<-`, `[[<-`, `unlist`.
#'
#' These are replaced by
#' `.c`, `.dim`, `.dim<-`, `.dollar`, `.dollar<-`, `.lapply`, `.length`,
#' `.lengths`, `.names`, `.names<-`, `.sapply`, `.subset`, `.subset2`, ,
#' `.subset<-`, `.subset2<-`, `.unlist`
#'
#' @param expr An expression to evaluate with temporary bindings
#' @return `local_bypass()` returns the values of old bindings invisibly;
#'  `with_bindings()` returns the value of expr.
#' @export
#' @name with_bypass
with_bypasses <- function(expr, .env = .GlobalEnv) {
  local_bypasses(.env = .env)
  expr
}

#' @export
#' @rdname with_bypass
local_bypasses <- function(.env = .GlobalEnv, .frame = parent.frame()) {
  rlang::local_bindings(!!!shims, .env = .env, .frame = .frame)
}

#' @export
#' @rdname with_bypass
local_bypass <- function(fun, cl, .env = .GlobalEnv, .frame = parent.frame()) {
  if (!is.null(cl)) {
    method_name <- sprintf("%s.%s", fun, .subset2(cl, 1))
    rlang::local_bindings(
      !!method_name := function(x, ...) NextMethod(object = NA),
      .env = .env,
      .frame = .frame
    )
  }
}

#' @export
#' @rdname with_bypass
with_bypass <- function(fun, cl, expr, .env = .GlobalEnv, .frame = parent.frame()) {
  local_bypass(fun, cl, .env, .frame)
  expr
}
