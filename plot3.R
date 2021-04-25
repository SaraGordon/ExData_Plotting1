setwd("/Users/saragordon/data")
library(dplyr)
library(lubridate)

##Read everything then subset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
allData <- read.table(unz(temp, "household_power_consumption.txt"), header = FALSE, sep = ";", dec = ".")
unlink(temp)

names(allData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")

##CMerge Date and Time and set date class
data$Date <- with(data, paste(Date, Time, sep="-"))
data$Date <- dmy_hms(data$Date)
data <- subset(data, select = -Time)

##Convert everything else to numeric
data$Global_active_power <- as.numeric(data$Global_active_power, na.rm = TRUE)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power, na.rm = TRUE)
data$Voltage <- as.numeric(data$Voltage, na.rm = TRUE)
data$Global_intensity <- as.numeric(data$Global_intensity, na.rm = TRUE)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1, na.rm = TRUE)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2, na.rm = TRUE)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3, na.rm = TRUE)

#Set up #PNG file
png(file = "plot3.png", width = 480, height = 480)

##Make the plot
plot(data$Date, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Metering")
points(data$Date, data$Sub_metering_1, type = "l")
points(data$Date, data$Sub_metering_2, col = "red", type = "l")
points(data$Date, data$Sub_metering_3, col = "blue", type = "l")

##Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), text.col = "black", lwd=1, lty=1)

##Turn off the device

dev.off()