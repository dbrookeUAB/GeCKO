prep_idt <- function(x){
  result <- copy(x)
  setkey(result, gene_id)
  result[, .N, gene_id] -> tmp
  setkey(tmp, "gene_id")
  tmp[result] -> result

# create idt_id_F ---------------------------------------------------------
  for (i in 1:6) {
    result[N == i, idt_id_F := paste0("F-", gene_id, paste0("_gRNA", 1:i))]
  }

# create create idt_id_R --------------------------------------------------
  for (i in 1:6) {
    result[N == i, idt_id_R := paste0("R-", gene_id, paste0("_gRNA", 1:i))]
  }

# create gRNA label -------------------------------------------------------
  result[, gRNA := stringr::str_extract(idt_id_F, "gRNA\\d")][]
  result <-
    result[, .SD, .SDcols = c(
      "gene_id",
      "gRNA",
      "seq",
      "idt_id_F",
      "oligo-1 (5'->3')",
      "idt_id_R",
      "oligo-2 (5'->3')"
    )]

 res_forward <- result[, .SD, .SDcols = c(
   "gene_id",
   "gRNA",
   "seq",
   "idt_id_F",
   "oligo-1 (5'->3')"
 )]

 colnames(res_forward)[4:5] <- c("Name","Sequence")

 res_reverse <- result[, .SD, .SDcols = c(
   "gene_id",
   "gRNA",
   "seq",
   "idt_id_R",
   "oligo-2 (5'->3')"
 )]

 colnames(res_reverse)[4:5] <- c("Name","Sequence")
 result <- rbind(res_forward,res_reverse)
 setkey(result, gene_id, gRNA)


  return(result)
}