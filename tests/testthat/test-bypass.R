test_that("bypass", {
  x <- structure(list(a = 1, b = 2), class = "foo")
  c.foo <- function(...) 42
  dim.foo <- function(...) 42
  `$.foo` <- function(...) 42
  lapply.foo <- function(...) 42
  length.foo <- function(...) 42
  lengths.foo <- function(...) 42
  names.foo <- function(...) 42
  sapply.foo <- function(...) 42
  `[.foo` <- function(...) 42
  `[[.foo` <- function(...) 42
  unlist.foo <- function(...) 42

  expect_snapshot({
    c(x)
    .c(x)
    dim(x)
    .dim(x)
    x$a
    .dollar(x, a)
    lapply(x, identity)
    .lapply(x, identity)
    sapply(x, identity)
    .sapply(x, identity)
    length(x)
    .length(x)
    names(x)
    .names(x)
    unlist(x)
    .unlist(x)
  })


  expect_equal(2 * 2, 4)
})
