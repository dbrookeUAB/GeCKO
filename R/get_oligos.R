#' Retrieve a precompiled list of gRNAs for GeCKO Vectors
#'
#' @return
#' @export
#'
#' @examples
get_oligos <- function(){
  require(data.table)
  require(fst)
  result <- fst::read_fst(system.file("extdata", "standard-gRNAs.fst", package = "GeCKO"),
                          as.data.table = TRUE)
  setkey(result, gene_id)
  return(result)
}
