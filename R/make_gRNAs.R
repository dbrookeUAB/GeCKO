#' Make gRNAs from GeCKO Library
#'
#' @param seqs
#' @param gene
#'
#' @return
#' @export
#'
#' @examples
make_gRNAs <- function(seqs,
                       gene = NULL,
                       add2 = list(
                         seq1_5p = "CACCG",
                         seq1_3p = "",
                         seq2_5p = "AAAC",
                         seq2_3p = "C")
){
  
  require(data.table, quietly = TRUE, warn.conflicts = FALSE)
  require(Biostrings, quietly = TRUE, warn.conflicts = FALSE)
  
  if(is.null(gene)){
    gRNA_name <- "gRNA-"
  } else {
    gRNA_name <- paste0(gene,".gRNA-")
  }
  
  voligo <- Vectorize(oligo_mod)
  # set gRNA 5' and 3' modifications ----------------------------------------
  
  seq1_5p <- add2$seq1_5p   # there has to be a more sophisticated way to do this
  seq1_3p <- add2$seq1_3p
  seq2_5p <- add2$seq2_5p
  seq2_3p <- add2$seq2_3p
  
  # define gRNAs ------------------------------------------------------------
  
  gRNA1 <- as.character(DNAStringSet(seqs))                       # 2114us

  
  
  # make complement ---------------------------------------------------------
  gRNA2 <- as.character(reverseComplement(DNAStringSet(seqs)))                     # 439us
  
  
  # oligo modifications -----------------------------------------------------
  gRNA1 <- voligo(seq1_5p,gRNA1,seq1_3p) 
  names(gRNA1) <- paste0(gRNA_name,gene)
  gRNA2 <- voligo( seq2_5p, gRNA2, seq2_3p)   
  names(gRNA2) <- paste0(gRNA_name,gene)# 1181us
  
  # make table (Benchmark = 1.503ms) ----------------------------------------
  gRNA1_dt <- make_table(gRNA1, "oligo-1 (5'->3')")     # 1504us
  gRNA2_dt <- make_table(gRNA2, "oligo-2 (5'->3')")     # 1504us
  
  result <- gRNA1_dt[gRNA2_dt]
  result[,gene_id:=paste0(gene)][]
  
  result[,.N,gene_id]-> tmp
  setkey(tmp, gene_id)
  tmp[result]-> result
  result[,seqs:=seqs][]
  
  for(i in 1:6){
    result[N==i,idt_id_F:=paste0("F-",gene_id,paste0("_gRNA",1:i))]
  }
  
  for(i in 1:6){
    result[N==i,idt_id_R:=paste0("R-",gene_id,paste0("_gRNA",1:i))]
  }
  
  result[,gRNA:=stringr::str_extract(idt_id_F, "gRNA\\d")][]
  result <- result[,.SD,.SDcols = c("gene_id","gRNA","seqs","idt_id_F","oligo-1 (5'->3')","idt_id_R","oligo-2 (5'->3')")]
  
  return(result)
}
