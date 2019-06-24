#' Make gRNAs from GeCKO Library
#'
#' @param seqs
#' @param gene
#'
#' @return
#' @export
#'
#' @importFrom stringr str_extract
#' @importFrom Rcpp evalCpp
#' @useDynLib GeCKO
#' 
#' @examples
#' 
#' # Make oligos from a single sequence
#' 
#' seq <- "TTCCTCACCTGATGATCTTG"
#' gene <- "GAPDH"
#' make_gRNAs(seq, gene)
#' 
#' # Make oligos for multiple gRNA sequences
#' human <- get_library(species = 'human')
#' 
#' seq <- human[gene_id=='GAPDH', seq]
#' gene <- human[gene_id=='GAPDH',gene_id]
#' 
#' make_gRNAs(seqs = seq, gene = gene)
#' 
make_gRNAs <- function(seqs,
                       gene = NULL,
                       seq1_5p = "CACCG",
                       seq1_3p = "",
                       seq2_5p = "AAAC",
                       seq2_3p = "C") {
  require(data.table, quietly = TRUE, warn.conflicts = FALSE)
  if (is.null(gene)) {
    gRNA_name <- "gRNA-"
  } else {
    gRNA_name <- paste0(gene, ".gRNA-")
  }

  # define gRNAs and make complement ----------------------------------------
  
  gRNA1 <- seqs
  gRNA2 <- revComplement(seqs)
  
  # oligo modifications -----------------------------------------------------
  result <- data.table(gene_id = gene,
                       seq = seqs,
                       `oligo-1 (5'->3')` = Voligo_mod( gRNA1,seq1_5p, seq1_3p),
                       `oligo-2 (5'->3')` = Voligo_mod(gRNA2, seq2_5p, seq2_3p)
  )
  
  return(result)
}
