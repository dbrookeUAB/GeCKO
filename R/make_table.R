make_table <- function(x, name ){
  require(data.table)
  result <- as.data.table(as.data.frame(x),
                          keep.rownames = "gene_id"
  )
  colnames(result)[2] <- name
  setkey(result, gene_id)

  return(result)
}


