#' Make gRNAs from GeCKO Library
#'
#' @param seqs
#' @param gene
#' @param add2
#'
#' @return
#' @export
#'
#' @importFrom stringr str_extract
#' @examples
make_gRNAsC <- function(seqs,
                       gene = NULL,
                       add2 = list(
                         seq1_5p = "CACCG",
                         seq1_3p = "",
                         seq2_5p = "AAAC",
                         seq2_3p = "C"
                       )) {
  require(data.table, quietly = TRUE, warn.conflicts = FALSE)
  require(Biostrings)
  if (is.null(gene)) {
    gRNA_name <- "gRNA-"
  } else {
    gRNA_name <- paste0(gene, ".gRNA-")
  }
  
  # set gRNA 5' and 3' modifications ----------------------------------------
  
  seq1_5p <- add2$seq1_5p   # there has to be a more sophisticated way to do this
  seq1_3p <- add2$seq1_3p
  seq2_5p <- add2$seq2_5p
  seq2_3p <- add2$seq2_3p
  
  # define gRNAs ------------------------------------------------------------
  
  gRNA1 <-
    as.character(Biostrings::DNAStringSet(seqs))                       # 2114us
  
  # make complement ---------------------------------------------------------
  gRNA2 <-
    as.character(Biostrings::reverseComplement(Biostrings::DNAStringSet(seqs)))                     # 439us
  
  # oligo modifications -----------------------------------------------------
  result <- data.table(gene_id = gene,
                       seq = seqs,
                       `oligo-1 (5'->3')` = Voligo_mod( gRNA1,seq1_5p, seq1_3p),
                       `oligo-2 (5'->3')` = Voligo_mod(gRNA2, seq2_5p, seq2_3p)
)
  
  return(result)
}
