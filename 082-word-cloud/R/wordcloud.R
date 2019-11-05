library(tm)
library(wordcloud)

# The list of valid books
books <<- list("A Mid Summer Night's Dream" = "summer",
              "The Merchant of Venice" = "merchant",
              "Romeo and Juliet" = "romeo")

loadBook <- function(book, dir="."){
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")

  readLines(file.path(dir, sprintf("./%s.txt.gz", book)),
                    encoding="UTF-8")
}

getTermMatrix <- function(text) {
  suppressWarnings({
    myCorpus = Corpus(VectorSource(text))
    myCorpus = tm_map(myCorpus, content_transformer(tolower))
    myCorpus = tm_map(myCorpus, removePunctuation)
    myCorpus = tm_map(myCorpus, removeNumbers)
    myCorpus = tm_map(myCorpus, removeWords,
         c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  })

  myDTM = TermDocumentMatrix(myCorpus,
              control = list(minWordLength = 1))

  m = suppressWarnings(as.matrix(myDTM))

  sort(rowSums(m), decreasing = TRUE)
}
