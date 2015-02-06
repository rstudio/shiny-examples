library(digest)
library(bit)

rawToInt <- function(bytes) {
  Reduce(function(left, right) {
    bitwShiftL(left, 8) + right
  }, as.integer(bytes), 0L)
}

# Quick and dirty bloom filter. The hashing "functions" are based on choosing
# random sets of bytes out of a single MD5 hash. Seems to work well for normal
# values, but has not been extensively tested for weird situations like very
# small n or very large p.
BloomFilter <- setRefClass("BloomFilter",
  fields = list(
    .m = "integer",
    .bits = "ANY",
    .k = "integer",
    .bytesNeeded = "integer",
    .bytesToTake = "matrix"
  ),
  methods = list(
    # @param n - Set size
    # @param p - Desired false positive probability (e.g. 0.01 for 1%)
    initialize = function(n = 10000, p = 0.001) {
      m = (as.numeric(n) * log(1 / p)) / (log(2)^2)
      
      .m <<- as.integer(m)
      .bits <<- bit(.m)
      .k <<- max(1L, as.integer(round((as.numeric(.m)/n) * log(2))))

      # This is how many *bytes* of data we need for *each* of the k indices we need to
      # generate
      .bytesNeeded <<- as.integer(ceiling(log2(.m) / 8))
      .bytesToTake <<- sapply(rep_len(.bytesNeeded, .k), function(byteCount) {
        # 16 is number of bytes an md5 hash has
        sample.int(16, byteCount, replace = FALSE)
      })
    },
    .hash = function(x) {
      hash <- digest(x, "md5", serialize = FALSE, raw = TRUE)
      sapply(1:.k, function(i) {
        val <- rawToInt(hash[.bytesToTake[,i]])
        # Scale down to fit into the desired range
        as.integer(val * (as.numeric(.m) / 2^(.bytesNeeded*8)))
      })
    },
    has = function(x) {
      all(.bits[.hash(x)])
    },
    set = function(x) {
      .bits[.hash(x)] <<- TRUE
    }
  )
)
