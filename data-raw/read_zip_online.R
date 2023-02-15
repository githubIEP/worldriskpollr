read_zip_online <- function(url,file.to.extract = NULL) {
  # args.check <- check.arguments(url, file.format)
  # if (!exit.success(args.check)) {
  #     return(1)
  # }
  
  temp <- tempfile()
  download.file(url, temp, mode = 'wb')
  x <- unzip(temp, list = T)
  if (is.null(file.to.extract)) {
    print(x)
    file.to.extract <- as.integer(readline(prompt = 'Enter file number: '))
  }
  data <- haven::read_sav(unz(temp, x$Name[file.to.extract]))
  unlink(temp)
  return(data)
}