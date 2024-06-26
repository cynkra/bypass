% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dimensions.R, R/helpers.R, R/subset.R,
%   R/vectors.R
\name{.length}
\alias{.length}
\alias{.lengths}
\alias{.dim}
\alias{.dim<-}
\alias{.names}
\alias{.names<-}
\alias{bypass-helpers}
\alias{.dollar}
\alias{.subset1}
\alias{.subset1<-}
\alias{.subset2<-}
\alias{.dollar<-}
\alias{.c}
\alias{.unlist}
\alias{.lapply}
\alias{.sapply}
\title{bypass helpers}
\usage{
.length(x)

.lengths(x, use.names = TRUE)

.dim(x)

.dim(x) <- value

.names(x)

.names(x) <- value

.dollar(e1, e2)

.subset1(x, ...)

.subset1(x, ...) <- value

.subset2(x, ...) <- value

.dollar(e1, e2) <- value

.c(...)

.unlist(x, recursive = TRUE, use.names = TRUE)

.lapply(X, FUN, ...)

.sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
}
\arguments{
\item{x, ..., value, use.names, e1, e2, recursive, X, FUN, simplify, USE.NAMES}{Forwarded to internal generic counterparts}
}
\description{
A collection of helpers that bypass the S3 dispatch of their internal
generic counterparts to fall back on the default behavior.
}
\details{
Note that \code{.subset2()} is already defined in base R as
ways to bypass the S3 dispatch of \code{[[}. We implemented \code{.subset1()} however
as a version of \code{base::.subset()} that doesn't strip attributes.
}
