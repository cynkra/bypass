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

