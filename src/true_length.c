#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>
#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

SEXP true_length(SEXP x) {
  SEXP len = PROTECT(allocVector (INTSXP, 1));
  INTEGER(len)[0] = length(x);
  UNPROTECT (1);
  return(len);
}
