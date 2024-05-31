# bypass

    Code
      c(x)
    Output
      [1] 42
    Code
      .c(x)
    Output
      $a
      [1] 1
      
      $b
      [1] 2
      
    Code
      dim(x)
    Output
      [1] 42
    Code
      .dim(x)
    Output
      NULL
    Code
      x$a
    Output
      [1] 42
    Code
      .dollar(x, a)
    Output
      [1] 1
    Code
      lapply(x, identity)
    Output
      $a
      [1] 1
      
      $b
      [1] 2
      
    Code
      .lapply(x, identity)
    Output
      $a
      [1] 1
      
      $b
      [1] 2
      
    Code
      sapply(x, identity)
    Output
      a b 
      1 2 
    Code
      .sapply(x, identity)
    Output
      a b 
      1 2 
    Code
      length(x)
    Output
      [1] 42
    Code
      .length(x)
    Output
      [1] 2
    Code
      names(x)
    Output
      [1] 42
    Code
      .names(x)
    Output
      [1] "a" "b"
    Code
      unlist(x)
    Output
      a b 
      1 2 
    Code
      .unlist(x)
    Output
      a b 
      1 2 

# dispatch

    Code
      fun <- (function() {
        x <- as.POSIXlt(c("2024-01-01", "2024-01-02"))
        local_bypass()
        names(x)
        with_dispatch(print(names(x)))
        names(x)
      })
      fun()
    Output
      NULL
       [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"  
       [9] "isdst"  "zone"   "gmtoff"

