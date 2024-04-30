shims <- NULL

.onLoad <- function(...) {
  # handled <- setdiff(
  #   ls(asNamespace("bypass"), all.names = TRUE, pattern = "^\\."),
  #   c(".__DEVTOOLS__", ".__NAMESPACE__.", ".__S3MethodsTable__.", ".onLoad", ".packageName")
  # )
  # toString(sprintf("`%s`", handled))
  # toString(sprintf("`%s`", names(shims)))

  shims <<- list(
    c = .c,
    dim = .dim,
    `dim<-` = `.dim<-`,
    `$` = .dollar,
    `$<-` = `.dollar<-`,
    lapply = .lapply,
    length = .length,
    lengths = .lengths,
    names = .names,
    `names<-` = `.names<-`,
    sapply = .sapply,
    `[` = .subset,
    `[[` = .subset2,
    `[<-` = `.subset<-`,
    `[[<-` = `.subset2<-`,
    unlist = .unlist
  )
}
