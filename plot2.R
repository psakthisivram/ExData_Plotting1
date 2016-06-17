library(downloader)

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
febData$datetime <- strptime(paste(febData$Date, febData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
png(file="plot2.png",width=480,height=480)
plot(febData$datetime, as.numeric(febData$Global_active_power), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
