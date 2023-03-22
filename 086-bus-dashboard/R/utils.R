

download_file <- function(url, destfile) {
    download.file(url, destfile, quiet = TRUE)
}

download_and_read <- function(url, destfile, read_fn, clean = FALSE) {
    if (!file.exists(destfile)) {
        download_file(url, destfile)
    }
    if (clean) {
        on.exit(unlink(destfile), add = TRUE)
    }

    read_fn(destfile)
}


# Method to recursively convert proto objects to lists
# Great for debugging
as_list <- function(x) {
    if (inherits(x, "Message")) {
        x <- as.list(x)
    }
    if (is.list(x)) {
        return(lapply(x, as_list))
    }
    x
}
