read_data <- function(method = "seats", file){
  # Read data from X13-ARIMA-SEATS
  # 
  # method  "seats" or "x11", series are in different files, depending on mehtod
  # file  full path without file ending
  #
  # return "mts" object

  
  # currently extracted final series (SEATS / X11)
  # seasonal        s10 final SEATS seasonal component               d10 final seasonal factors
  # seasonaladj     s11 final SEATS seasonal adjustment component    d11 final seasonally adjusted series
  # trend           s12 final SEATS trend component                  d12 final trend-cycle
  # irregular       s13 final SEATS irregular component              d13 final irregular component
  # adjustfac       s16 final SEATS combined adjustment factors      d16 combined seasonal and trading day factors

  if (identical(method, "seats")){
    seasonal        <- read_data_file(paste0(file, ".s10"))
    seasonaladj     <- read_data_file(paste0(file, ".s11"))
    trend           <- read_data_file(paste0(file, ".s12"))
    irregular       <- read_data_file(paste0(file, ".s13"))
    adjustfac       <- read_data_file(paste0(file, ".s16"))
  } else if (identical(method, "x11")){
    seasonal        <- read_data_file(paste0(file, ".d10"))
    seasonaladj     <- read_data_file(paste0(file, ".d11"))
    trend           <- read_data_file(paste0(file, ".d12"))
    irregular       <- read_data_file(paste0(file, ".d13"))
    adjustfac       <- read_data_file(paste0(file, ".d16"))
  } else {
    stop("wrong method.")
  }
  
  residuals <- read_data_file(paste0(file, ".rsd"))

  if (file.exists(paste0(file, ".saa"))){
    final <- read_data_file(paste0(file, ".saa"))
  } else {
    final <- seasonaladj
  }

  cbind(final, seasonal, seasonaladj, trend, irregular, adjustfac,
        residuals)
}


read_data_file <- function(file){
  # Read data from a particular X13-ARIMA-SEATS file
  # 
  # file  full path including file ending
  #
  # return a "ts" object
  
  
  dta <- read.table(file, stringsAsFactors = F)
  series <- as.numeric(dta[-c(1,2) ,2])
  
  time.raw <- as.numeric(dta[-c(1,2) ,1])
  year <- str_sub(time.raw, start = 1, end = 4)
  per <- str_sub(time.raw, start = 5, end = 6)
  
  if (length(unique(per)) == 4){
    frequency <- 4
  } else if (length(unique(per)) == 12){
    frequency <- 12
  } else {
    warning("Frequency determination is unclear. Assuming monthly data.")
    frequency <- 12
  }
  
  time <- as.numeric(year) + (as.numeric(per) - 1) / frequency
  z <- ts(series, start = time[1], frequency = frequency)
  z
}

