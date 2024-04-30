#' Bypass S3 Methods
#'
#' * `with_bypass()` evaluates `expr` without triggering S3 methods for some curated
#'  internal generics (see details)
#' * `local_bypass()` sets up a function not to trigger these S3 methods from the
#'   function's code
#'
#' `with_bypass()` and `local_bypass()` override
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
with_bypass <- function(expr, .env = .GlobalEnv) {
  local_bypass(.env = .env)
  expr
}

#' @export
#' @rdname with_bypass
local_bypass <- function(.env = .GlobalEnv, .frame = parent.frame()) {
  rlang::local_bindings(!!!shims, .env = .env, .frame = .frame)
}

local_bypass0 <- function(fun, cl, .env = .GlobalEnv, .frame = parent.frame()) {
  if (!is.null(cl)) {
    method_name <- sprintf("%s.%s", fun, .subset2(cl, 1))
    rlang::local_bindings(
      !!method_name := function(x, ...) NextMethod(object = NA),
      .env = .env,
      .frame = .frame
    )
  }
}

with_bypass0 <- function(fun, cl, expr, .env = .GlobalEnv, .frame = parent.frame()) {
  local_bypass0(fun, cl, .env, .frame)
  expr
}
