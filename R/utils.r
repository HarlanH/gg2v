is.waiver <- function(x) inherits(x, "waiver")

"%||%" <- function(a, b) {
  if (is.null(a) || is.waiver(a)) b else a
}


"append<-" <- function(x, value) {
  if (is.null(x)) {
    list(value)
  } else {
    c(x, list(value))
  }
}

compact <- function(x) Filter(Negate(is.null), x)

maybe <- function(f) {
  function(x, ...) {
    if (is.null(x) || length(x) == 0) return()
    f(x, ...)
  }
}

modify_list <- function(x, y, recurse = FALSE) {
  if (is.null(x)) x <- list()
  if (is.null(y)) y <- list()

  if (recurse) {
    modifyList(x, y)
  } else {
    x[names(y)] <- y
    x
  }

}

is.dir <- function(x) {
  file.info(x)$isdir
}


invert <- function(L) {
  t1 <- unlist(L)
  names(t1) <- rep(names(L), lapply(L, length))
  tapply(names(t1), t1, c)
}


has_name <- function(nm, x) {
  nm %in% names(x)
}

failwith <- function(default = NULL, f, quiet = FALSE) {
  f <- match.fun(f)
  function(...) {
    out <- default
    try(out <- f(...), silent = quiet)
    out
  }
}


combine <- function(x, y) {
  n <- length(x)
  for(i in seq_along(y)) {
    x[[n + i]] <- y[[i]]
  }
  x
}

combine2 <- function(x, y) {
  n <- length(x)
  for(i in seq_along(y)) {
    x[[n + i]] <- y[[i]]
    names(x)[[n+i]] <- names(y)[[i]]
  }
  x
}
