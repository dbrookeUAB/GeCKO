oligo_1 <- function(x, seq1_5p = "CACCG", seq1_3p = ""){
  oligo5p <- DNAString(seq1_5p)
  oligo3p <- DNAString(seq1_3p)

  if(class(x)=="DNAStringSet"){
    result <- DNAStringSet(lapply(x, function(y) c(oligo5p,y,oligo3p)))
  } else if(class(x)=="DNAString"){
    result <- c(oligo5p,x,oligo3p)
  } else {
    stop("Must use DNA sequence(s)",call. = FALSE)
  }

  return(result)
}

oligo_2 <- function(x, seq2_5p = "AAAC", seq2_3p = "C"){
  oligo5p <- DNAString(seq2_5p)
  oligo3p <- DNAString(seq2_3p)

  if(class(x)=="DNAStringSet"){
    result <- DNAStringSet(lapply(x, function(y) c(oligo5p,y,oligo3p)))
  } else if(class(x)=="DNAString"){
    result <- c(oligo5p,x,oligo3p)
  } else {
    stop("Must use DNA sequence(s)",call. = FALSE)
  }

  return(result)
}
