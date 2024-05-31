
# bypass

{bypass} provides a way to use the default behavior of internal
generics, bypassing the S3 methods. This makes working with objects at
the low level much easier and safer.

We provide counterparts to existing functions:

| {base}   | {bypass}    |
|----------|-------------|
| c        | .c          |
| dim      | .dim        |
| dim\<-   | .dim\<-     |
| \$       | .dollar     |
| \$\<-    | .dollar\<-  |
| lapply   | .lapply     |
| length   | .length     |
| lengths  | .lengths    |
| names    | .names      |
| names\<- | .names\<-   |
| sapply   | .sapply     |
| \[       | .subset1    |
| \[\<-    | .subset1\<- |
| \[\[\<-  | .subset2\<- |
| unlist   | .unlist     |

Note that base R already has `.subset2()` as a low level counterpart to
`[[`. `.subset1()` is different from `.subset()` because it doesn’t lose
attributes other than names and works on matrices. `.dollar()` is a
wrapper around `.subset2()` so we also lose the partial matching of the
original `$` function.

Other functions are provided :

- `with_bypass()` allows you to type the base versions in the `.expr`
  argument and get the bypass behavior
- `local_bypass()` does the same but locally for the function in which
  it’s called
- `global_bypass()` does this for a full package, it’s meant to be used
  in `.onLoad()`
- `with_dispatch()` and `local_dispatch()` are the reverse of
  `with_bypass()` and `local_bypass()`, they re-enable dispatch when
  it’s been disabled by the other functions.

These are especially useful useful for `[<-` and `[[<-` which are tricky
to use at the low level, as they need a lot of unclassing/reclassing.

## Installation

Install with:

``` r
pak::pak("cynkra/bypass")
```

## Example 1

At the high level POSIXlt objects look like simple vectors, and behave
that way:

``` r
library(bypass)
x <- as.POSIXlt(c("2024-01-01", "2024-01-02"))
length(x)
#> [1] 2
names(x)
#> NULL
```

But in fact “POSIXlt” objects are not atomic vectors but named lists of
vectors, S3 methods, for `length()`, `names()`, and more, are defined so
we can treat them just like vectors.

Here’s another way we might have used to define the above object:

``` r
list(
  sec = c(0, 0),
  min = c(0L, 0L),
  hour = c(0L, 0L),
  mday = 1:2,
  mon = c(0L, 0L),
  year = c(124L, 124L),
  wday = 1:2,
  yday = 0:1,
  isdst = c(0L, 0L),
  zone = c("CET", "CET"),
  gmtoff = c(NA_integer_, NA_integer_)
) |>
  structure(class = c("POSIXlt", "POSIXt"), tzone = c("", "CET", "CEST"), balanced = TRUE)
#> [1] "2024-01-01 CET" "2024-01-02 CET"
```

The `.length()` and `.names()` functions can be used to access the low
level length and names, these are roughly equivalent to
`length(unclass(x))` and `names(unclass(x))` respectively, with special
cases for environments.

``` r
.length(x)
#> [1] 11
.names(x)
#>  [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"  
#>  [9] "isdst"  "zone"   "gmtoff"
```

The functions `with_bypass()`, `local_bypass()` and `global_bypass()`
provide different ways to use the native syntax rather than dotted
counterparts.

``` r
# with_bypass
with_bypass(names(x))
#>  [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"  
#>  [9] "isdst"  "zone"   "gmtoff"

# local_bypass
fun <- function() {
  local_bypass()
  names(x)
}
fun()
#>  [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"  
#>  [9] "isdst"  "zone"   "gmtoff"

# global_bypass (in a package)
.onLoad <- function(libname, pkgname) {
  bypass::global_bypass(asNamespace(pkgname))
}
# then names() will behave like .names() in the whole package
```

Low level replacement is one of the most useful features.

``` r
# without bypass
x <- as.POSIXlt(c("2024-01-01", "2024-01-02"))
cl <- class(x)
x <- unclass(x)
x$year <- c(120L, 121L)
class(x) <- cl
x
#> [1] "2020-01-01 CET" "2021-01-02 CET"

# with bypass
x <- as.POSIXlt(c("2024-01-01", "2024-01-02"))
with_bypass({
  x$year <- c(120L, 121L)
})
x
#> [1] "2020-01-01 CET" "2021-01-02 CET"
```

In case of replacement of nested elements the difference between both
approaches will be even bigger.

## Example 2

``` r
x <- structure(list(a = 1, b = 2), class = "foo")
c.foo <- function(...) 42
dim.foo <- function(...) 42
`$.foo` <- function(...) 42
length.foo <- function(...) 42
lengths.foo <- function(...) 42
names.foo <- function(...) 42
`[.foo` <- function(...) 42
`[[.foo` <- function(...) 42
unlist.foo <- function(...) 42
  
c(x)
#> [1] 42
.c(x)
#> $a
#> [1] 1
#> 
#> $b
#> [1] 2

dim(x)
#> [1] 42
.dim(x)
#> NULL

x$a
#> [1] 42
.dollar(x, a)
#> [1] 1

lapply(x, identity)
#> $a
#> [1] 42
#> 
#> $b
#> [1] 42
.lapply(x, identity)
#> $a
#> [1] 1
#> 
#> $b
#> [1] 2

sapply(x, identity)
#>  a  b 
#> 42 42
.sapply(x, identity)
#> a b 
#> 1 2

length(x)
#> [1] 42
.length(x)
#> [1] 2

names(x)
#> [1] 42
.names(x)
#> [1] "a" "b"

unlist(x)
#> [1] 42
.unlist(x)
#> a b 
#> 1 2

# NOTE: `local_bypass()` should normally be called in a function so we don't 
# change the global state, here for demo purposes:
local_bypass()
c(x)
#> $a
#> [1] 1
#> 
#> $b
#> [1] 2
dim(x)
#> NULL
x$a
#> [1] 1
lapply(x, identity)
#> $a
#> [1] 1
#> 
#> $b
#> [1] 2
sapply(x, identity)
#> a b 
#> 1 2
length(x)
#> [1] 2
names(x)
#> [1] "a" "b"
unlist(x)
#> a b 
#> 1 2
```
