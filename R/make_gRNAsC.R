#' Make gRNAs from GeCKO Library
#'
#' @param seqs
#' @param gene
#'
#' @return
#' @export
#'
#' @examples
make_gRNAsC <- function(seqs,
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


#> single gene test
# Unit: microseconds
#               expr      min       lq      mean    median        uq      max neval cld
#       DNAStringSet 1558.531 1673.946 2113.9704 1726.5110 1826.7825 81162.88  1000   b
#  reverseComplement  710.120  827.403  991.1061  866.5380  914.5375 73391.40  1000  a
#         make_table  677.506  822.937 1066.5767  881.0995  924.2980 74125.03  1000  a
#             oligo1 1023.619 1119.830 1893.2008 1166.2465 1254.9470 80180.46  1000   b
#             oligo2 1026.580 1132.272 1328.7268 1181.0245 1266.5380 20186.45  1000  a

#> multiple gene test
#Unit: microseconds
#              expr       min         lq       mean     median         uq       max neval cld
#      DNAStringSet   353.459   408.2300   498.4731   437.7015   485.5425   3154.49  1000 a
# reverseComplement  2151.937  2320.3620  2966.6651  2428.1330  2721.6225  82927.13  1000  b
#        make_table   665.934   851.8195  1056.2470   886.9890   957.0280  78562.03  1000 a
#            oligo1 12329.865 13297.8920 18471.8634 14519.3850 15766.6605 168441.77  1000   c
#            oligo2 12436.792 13428.8840 19169.0469 14595.0835 15891.0245 526917.68  1000   c



