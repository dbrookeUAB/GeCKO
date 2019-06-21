#' Loading the GeCKO libraries
#'
#' @param species
#'
#' @return
#' @export
#'
#' @examples
get_library <- function(species = "human"){
  require(data.table)
  require(fst)
  file_name <- paste0(species, ".fst")
  result <- fst::read_fst(system.file("extdata", file_name, package = "GeCKO"),
                          as.data.table = TRUE)
  setkey(result, gene_id)
  return(result)
}

