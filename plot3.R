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

# extract header names
header <- strsplit(readLines("./household_power_consumption.txt", n = 1), ";")

# filter feb 1st and 2nd data
febData <- read.table("./household_power_consumption.txt",skip=66636, nrows = 2880, header = TRUE, sep = ";", na.strings = c("?"), col.names = c(unlist(header)))

# concat data and time
febData$datetime <- strptime(paste(febData$Date, febData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# open device
png(file="plot3.png",width=480,height=480)

# create plot between time and sub metering
plot(febData$datetime, as.numeric(febData$Sub_metering_1), type = "l", xlab = "", ylab = "Energy sub metering")
lines(febData$datetime, as.numeric(febData$Sub_metering_2), col="red")
lines(febData$datetime, as.numeric(febData$Sub_metering_3), col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=grep("Sub_metering_*", names(febData), value = TRUE))

# turnoff device
dev.off()
