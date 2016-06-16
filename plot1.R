library(downloader)
library(lubridate)

filename <- "household_power_consumption.zip"

# Download dataset
if (!file.exists(filename)){
  fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  require(downloader)
  download(fileUrl, filename, mode = "wb")
}  

# Unzip dataset
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

header <- strsplit(readLines("./household_power_consumption.txt", n = 1), ";")
febData <- read.table("./household_power_consumption.txt",skip=66636, nrows = 2880, header = TRUE, sep = ";", na.strings = c("?"), col.names = c(unlist(header)))

png(file="plot1.png",width=480,height=480)
hist(febData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
