#' @export
#' @rdname has_rtools
rtools_path <- function() {
  cache_get("rtools_path")
}

rtools_path_is_set <- function() {
  cache_exists("rtools_path")
}

rtools_path_set <- function(rtools) {
  stopifnot(is.rtools(rtools))
  path <- file.path(rtools$path, version_info[[rtools$version]]$path)

  # If using gcc49 and _without_ a valid BINPREF already set
  if (using_gcc49() && is.null(rtools$valid_binpref)) {
    Sys.setenv(BINPREF = file.path(rtools$path, "mingw_$(WIN)", "bin", "/"))
  }

  cache_set("rtools_path", path)
}

using_gcc49 <- function() {
  isTRUE(sub("^gcc[^[:digit:]]+", "", Sys.getenv("R_COMPILED_BY")) >= "4.9.3")
}
