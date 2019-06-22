export_IDT <- function(Sequence, Name, file,...){
  require(data.table)
  tmp <- data.table(Name, Sequence, Scale = "25nmS", Purifcation = "STD")
  if(grepl("\\.xlsx$",file)){
    fwrite(tmp,file = file,...)
  } else {
    stop("file name must end with .xlsx to use with the IDT batch upload", call. = FALSE)
  }
  
}