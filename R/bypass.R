#' Bypass S3 Methods
#'
#' * `with_bypass()` evaluates `expr` without triggering S3 methods for some curated
#'  internal generics (see details)
#' * `local_bypass()` sets up a function not to trigger these S3 methods from the
#'   function's code
#' * `global_bypass()` overrides internal generics to set the behavior globally
#'   in a given environment, it's designed with packages in mind (use
#'   `bypass::global_bypass(asNamespace(pkgname))` in `.onLoad()`)
#' * `with_dispatch()` and `local_dispatch()` are the reverse of `with_bypass()`
#'   and `local_bypass()`, they re-enable dispatch when it's been disabled by
#'   the other functions.
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
#' @inheritParams rlang::local_bindings
#'
#' @return `local_bypass()` returns the values of old bindings invisibly;
#'  `with_bindings()` returns the value of expr.
#' @export
#' @name with_bypass
with_bypass <- function(.expr, .env = .GlobalEnv) {
  local_bypass(.env = .env)
  .expr
}

#' @export
#' @rdname with_bypass
local_bypass <- function(.env = .GlobalEnv, .frame = parent.frame()) {
  rlang::local_bindings(!!!shims_for_bypass, .env = .env, .frame = .frame)
}

#' @export
#' @rdname with_bypass
global_bypass <- function(.env = .GlobalEnv) {
  for (nm in names(shims_for_bypass)) {
    assign(nm, shims_for_bypass[[nm]], .env)
  }
}

#' @export
#' @name with_bypass
with_dispatch <- function(.expr, .env = .GlobalEnv) {
  local_dispatch(.env = .env)
  .expr
}

#' @export
#' @rdname with_bypass
local_dispatch <- function(.env = .GlobalEnv, .frame = parent.frame()) {
  rlang::local_bindings(!!!shims_for_dispatch, .env = .env, .frame = .frame)
}
