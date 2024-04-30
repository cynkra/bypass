
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
| \[\<-    | .subset\<-  |
| \[\[\<-  | .subset2\<- |
| unlist   | .unlist     |

Note that base R already has `.subset()` and `.subset2()` as low level
counterparts to `[` and `[[`. check also {rlang} for low level versions
of `is.symbol()`, `is.na()` etc

Additionally the functions `with_bypass()` and `local_bypass()` allow
you to locally type the base versions and get the bypass behavior. This
is especially useful for `[<-` and `[[<-`.

## Installation

You can install the development version of bypass like so:

``` r
pak::pak("cynkra/bypass")
```

## Example 1

``` r
library(bypass)
#> 
#> Attaching package: 'bypass'
#> The following object is masked from '.Rprofile':
#> 
#>     .c
## from ?bibentry
rref <- bibentry(
   bibtype = "Manual",
   title = "R: A Language and Environment for Statistical Computing",
   author = person("R Core Team"),
   organization = "R Foundation for Statistical Computing",
   address = "Vienna, Austria",
   year = 2014,
   url = "https://www.R-project.org/"
   )

# The S3 method makes the object hard to manipulate
identical(rref[[1]][[1]], rref)
#> [1] TRUE

# Base R helps here
.subset2(rref, c(1, 1))
#> [1] "R: A Language and Environment for Statistical Computing"

# though it looks bad when we want to combine indices types
.subset2(rref, 1) |> .subset2("title")
#> [1] "R: A Language and Environment for Statistical Computing"

# with {bypass} we can use the standard syntax
with_bypass(rref[[1]][["title"]])
#> [1] "R: A Language and Environment for Statistical Computing"

# `local_bypass()` is meant to be used in functions and is probably what
# you'll want to use
fun <- function(x) {
  local_bypass()
  x[[1]]$title <- "!!!!!!!!!!!!!!!!"
  x
}
fun(rref)
#> R Core Team (2014). _!!!!!!!!!!!!!!!!_. R Foundation for Statistical
#> Computing, Vienna, Austria. <https://www.R-project.org/>.
```

## Example 2

``` r
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
