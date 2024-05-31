shims_for_bypass <- NULL
shims_for_dispatch <- NULL

.onLoad <- function(...) {
  shims_for_bypass <<- list(
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
    `[` = .subset1,
    `[[` = .subset2,
    `[<-` = `.subset1<-`,
    `[[<-` = `.subset2<-`,
    unlist = .unlist
  )

  shims_for_dispatch <<- list(
    c = c,
    dim = dim,
    `dim<-` = `dim<-`,
    `$` = `$`,
    `$<-` = `$<-`,
    lapply = lapply,
    length = length,
    lengths = lengths,
    names = names,
    `names<-` = `names<-`,
    sapply = sapply,
    `[` = `[`,
    `[[` = `[[`,
    `[<-` = `[<-`,
    `[[<-` = `[[<-`,
    unlist = unlist
  )
}
