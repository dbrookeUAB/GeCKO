export_IDT <- function(x, file,...){
  require(data.table)
  tmp <- prep_idt(x)
  
  tmp <- data.table(Name = tmp$Name,Sequence =tmp$Sequence, Scale = "25nmS", Purifcation = "STD")
  if(grepl("\\.xlsx$",file)){
    fwrite(tmp,file = file,...)
  } else {
    stop("file name must end with .xlsx to use with the IDT batch upload", call. = FALSE)
  }
  
}